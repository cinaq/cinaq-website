---
title: "Speed up docker builds with distcc, ccache and kubernetes"
date: 2020-05-10T13:37:00+00:00
draft: false
---

For a recent project I had to write my own Orthanc plugin. To build this plugin I needed to build [Orthanc](https://wwww.orthanc-server.com) from source. The [official docker-images](https://github.com/jodogne/OrthancDocker) are assembled based on pre-built binaries. So I could not use them.

# Orthanc Dockerfile

The first step is create a Dockerfile that compiles Orthanc from source. Looking through the [compilation instructions](https://bitbucket.org/sjodogne/orthanc/src/Orthanc-1.6.0/LinuxCompilation.txt) and inspired by the official docker images I have assembled the following Dockerfile:

{{< highlight bash >}}
FROM debian:stable AS builder

WORKDIR /root
ENV ORTHANC_VERSION 1.6.0

RUN apt update && apt install -y build-essential unzip cmake mercurial \
    uuid-dev libcurl4-openssl-dev liblua5.1-0-dev \
    libgtest-dev libpng-dev libjpeg-dev \
    libsqlite3-dev libssl-dev zlib1g-dev libdcmtk2-dev \
    libboost-all-dev libwrap0-dev libjsoncpp-dev libpugixml-dev distcc

# pull source from upstream
RUN hg clone -b Orthanc-${ORTHANC_VERSION} --stream https://bitbucket.org/sjodogne/orthanc Orthanc

# distcc
ARG JOBS=4
ARG DISTCC_HOSTS=localhost/4
RUN echo "${DISTCC_HOSTS}" > /etc/distcc/hosts
ARG XXX=1


RUN mkdir OrthancBuild
RUN cd OrthancBuild && cmake -DALLOW_DOWNLOADS=ON \
#    -DSTATIC_BUILD=ON \
    -DCMAKE_CXX_COMPILER_LAUNCHER=distcc \
    -DUSE_SYSTEM_CIVETWEB=OFF \
    -DUSE_GOOGLE_TEST_DEBIAN_PACKAGE=OFF \
    -DDCMTK_LIBRARIES=dcmjpls \
    -DCMAKE_BUILD_TYPE=Release \
    ~/Orthanc

RUN cd OrthancBuild && make -j ${JOBS}

FROM debian:stable-slim

# locales
RUN apt-get update && apt install -y locales wget
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen

RUN mkdir -p \
    /etc/orthanc \
    /var/lib/orthanc/db \
    /usr/local/sbin/ \
    /usr/local/bin/ \
    /usr/local/share/orthanc/plugins/

COPY --from=builder /root/OrthancBuild/Orthanc /usr/local/sbin/
COPY --from=builder /root/OrthancBuild/OrthancRecoverCompressedFile /usr/local/sbin/
COPY --from=builder /root/OrthancBuild/lib* /usr/local/share/orthanc/plugins/

VOLUME [ "/var/lib/orthanc/db" ]
EXPOSE 4242
EXPOSE 8042

ENTRYPOINT [ "Orthanc" ]
CMD [ "/etc/orthanc/" ]

# https://groups.google.com/d/msg/orthanc-users/qWqxpvCPv8g/Z8huoA5FDAAJ
ENV MALLOC_ARENA_MAX 5
{{< / highlight >}}

# Docker build

Build the image with

{{< highlight bash >}}
docker build . -t orthanc:latest
{{< / highlight >}}

Above command takes around 6min (excluding the remote dependencies) to complete on my Macbook pro. Since I'm expecting to build more regularly, I started to look around to speed up the process. I found the following options:

* Use a [different docker image as cache](https://vsupalov.com/cache-docker-build-dependencies-without-volume-mounting/)
* Use experimental [RUN --mount](https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/experimental.md)
* Use [ccache](https://ccache.dev/), alone this has no advantage for docker builds because the cache directory is flushed for every build.
* Use [distcc](https://distcc.github.io/) to offload some compilation operations to external host
* Finally I decided to combine `distcc` with local caching of `ccache`.

The idea is not new. [First resource](https://lastviking.eu/distcc_with_k8.html) I found was very useful to show distcc usage in kubernetes. However it wasn't enough as I didn't think the solution is very elegant. So then I found a [second article](https://wilsonhongblog.wordpress.com/2016/05/24/using-ccache-on-distcc-server/) with cleaner solution on combining `distcc` with `ccache`.


# cinaq/distcc

As a result I have combined both articles into a simple to use distcc-ccache-kubernetes setup. It's documented at [cinaq/distcc-docker](https://github.com/cinaq/distcc-docker).

With [cinaq/distcc](https://hub.docker.com/r/cinaq/distcc) running in Kubernetes, we can now compile Orthanc 2 times as fast with:

{{< highlight bash >}}
docker build . --build-arg DISTCC_HOSTS=distcc.dev/4 --build-arg JOBS=4 -t orthanc:latest
{{< / highlight >}}

Here we pass 2 build arguments:

* DISTCC_HOSTS: distcc.dev/4 where `distcc.dev` is the hostname of our distcc (cluster)  and 4 is number of jobs to send
* JOBS: 4, denotes the total number of jobs `make` will run in parallel. We should be able to increase this more. We left this value the same for both test cases to confirm distcc and ccache do speed up the overal build process.

We can observe the logs of `distcc` service:

{{< highlight bash >}}
kubectl logs distcc-deployment-5d6fb547d7-z2rlv
distccd[11] (dcc_job_summary) client: 10.1.28.1:59075 COMPILE_OK exit:0 sig:0 core:0 ret:0 time:4342ms /usr/lib/ccache/c++ /root/Orthanc/Core/Cache/MemoryCache.cpp
distccd[10] (dcc_job_summary) client: 10.1.28.1:59074 COMPILE_OK exit:0 sig:0 core:0 ret:0 time:7109ms /usr/lib/ccache/c++ /root/Orthanc/Core/Cache/MemoryObjectCache.cpp
distccd[12] (dcc_job_summary) client: 10.1.28.1:59090 COMPILE_OK exit:0 sig:0 core:0 ret:0 time:4178ms /usr/lib/ccache/c++ /root/Orthanc/Core/Cache/MemoryStringCache.cpp
...
{{< / highlight >}}

 And the cache being populated:
{{< highlight bash >}}
 kubectl exec -it distcc-deployment-5d6fb547d7-z2rlv -- /bin/ls -l /cache
total 68
drwxr-xr-x 13 distcc distcc 4096 May 10 19:37 0
drwxr-xr-x 10 distcc distcc 4096 May 10 19:36 1
drwxr-xr-x  6 distcc distcc 4096 May 10 19:36 2
drwxr-xr-x 10 distcc distcc 4096 May 10 19:37 3
drwxr-xr-x 11 distcc distcc 4096 May 10 19:37 4
drwxr-xr-x  9 distcc distcc 4096 May 10 19:35 5
drwxr-xr-x  9 distcc distcc 4096 May 10 19:35 6
drwxr-xr-x  6 distcc distcc 4096 May 10 19:37 7
drwxr-xr-x 11 distcc distcc 4096 May 10 19:37 8
drwxr-xr-x 14 distcc distcc 4096 May 10 19:37 9
drwxr-xr-x 13 distcc distcc 4096 May 10 19:37 a
drwxr-xr-x 11 distcc distcc 4096 May 10 19:37 b
drwxr-xr-x 13 distcc distcc 4096 May 10 19:37 c
-rw-r--r--  1 distcc distcc   16 May 10 19:32 ccache.conf
drwxr-xr-x 10 distcc distcc 4096 May 10 19:37 d
drwxr-xr-x  9 distcc distcc 4096 May 10 19:36 e
drwxr-xr-x 11 distcc distcc 4096 May 10 19:37 f
{{< / highlight >}}

The new build takes 3min to complete to build Orthanc from source. 

# Conclusions

Honestly I was expecting much higher speed up. But 50% time reduction is very nice nonetheless. I really liked breathing new fresh life into mature tools like `distcc` and `ccache` in a modern stack.

# Future work

* Scale up number of pods running `distcc` could speed up the process further. Not sure how distcc will react because there would be multiple distcc instances behind a single LoadBalancer host.
* dive deeper into `distcc` for optimal parameters could also result in speed up.
* allow usage of `Persistent Volume` instead of `EmptyDir` so that caches are persisted longer than the pod lifetime.
* package this up into a [helm chart](https://helm.sh/docs/topics/charts/).

