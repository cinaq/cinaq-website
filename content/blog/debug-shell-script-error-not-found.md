---
title: "Debug shell script error: not found"
date: 2019-05-29T00:13:37+01:00
draft: false
tags: ["bash", "shell", "linux", "strace", "script", "shellscript", "exec"]
categories: ['Development', 'DevOps']
authors: ['Xiwen Cheng']
description: Shell scripts are easy to write and very effective in solving practical problems. However sometimes its error messages are very cryptic.
thumbnail: '/media/dan-wilding-ewFbCoV3kA4-unsplash.jpg'
image: '/media/dan-wilding-ewFbCoV3kA4-unsplash.jpg'
aliases:
  - /post/2019/05/29/debug-shell-script-error-not-found/
---

Automation engineers often have boring tasks. Their job is to automate repetitive tasks. In the early days of Unix and Linux most automation is done with shell scripts. Nowadays we use higher level configuration management systems like [Ansible](https://www.ansible.com/), [Puppet](https://puppet.com/), [Salt](https://www.saltstack.com/), etc replacing most of the erroneous scripts with poor error handling, lots of boiler code and more importantly high maintenance cost.

```bash
$ ./main.sh
./main.sh: 3: exec: ./external.sh: not found
$ ls -l
-rwxr-xr-x 1 xiwen xiwen 33 May 29 01:25 external.sh
-rwxr-xr-x 1 xiwen xiwen 38 May 29 02:01 main.sh
```

{{< figure src="https://media.giphy.com/media/xT0xeuOy2Fcl9vDGiA/giphy.gif" caption="What is this?" >}}

Even though we have these fantastic tools we often fall back to shell. It’s still the favorite method of quickly drafting a script improving our efficiency. Also shell scripts are reasonably portable without dependency on some tools that might be absent; every Linux system is shipped with a shell. Since it is so easy to create and use them, shell scripts are still widely used.

## Poor feedback from shell script

As pointed out earlier error handling is often minimal in shell scripts. This is a natural consequence because scripts focusses being short. Therefore happy case is the only use case supported. Error handling relies on the child tools/processes to give useful feedback on error.

A simplified case is as follow.

We have our entry-point script called `main.sh` containing:

```bash
#!/usr/bin/env sh

exec ./external.sh
```

And our `external.sh` contains:

```bash
#!/usr/bin/env sh

echo Hello $0
```

Create these files on your system and make them executable so that you can run them:

```bash
chmod +x main.sh
chmod +x external.sh
```

Running the script `./main.sh` fails with:

```bash
./main.sh: 3: exec: ./external.sh: not found
```

First reaction is: what does this mean?

`exec` function is complaining about `./external.sh` cannot be found. At least that was my initial interpretation. However that does not make any sense because `./external.sh` script does exist. That is very confusing.

## Debugging with `strace`

[Strace](https://linux.die.net/man/1/strace) is diagnostic utility for Linux. Let's use it to debug our original program. The result of `strace ./main.sh` looks like:

```bash
... snip ...
read(10, "#!/usr/bin/env sh\n\nexec ./extern"..., 8192) = 38
execve("./external.sh", ["./external.sh"], 0x5632d3cf8038 /* 68 vars */)
  = -1 ENOENT (No such file or directory)
write(2, "./main.sh: 3: exec: ", 20./main.sh: 3: exec: )    = 20
write(2, "./external.sh: not found", 24./external.sh: not found) = 24
write(2, "\n", 1
)                       = 1
exit_group(127)                         = ?
+++ exited with 127 +++
```

It doesn't give us any new information. Still a confusing error message.

## Manual debugging

How about we run `./external.sh` ourselves?

```bash
bash: ./external.sh: /usr/bin/envsh: bad interpreter:
  No such file or directory
```

Aha! There was a typo in the interpreter path on the [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) line. That resulted in a rather cryptic error message. Fixing the shebang typo to `#!/usr/bin/env sh` in `./external.sh` our main script works:

```bash
Hello ./external.sh
```

## Use `bash` as alternative

Let's change our shell interpreter from [Bourne Shell](https://en.wikipedia.org/wiki/Bourne_shell) to [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) in `main.sh`:

```bash
#!/usr/bin/env bash

exec ./external.sh
```

Now the error message is:

```bash
./main.sh: /tmp/external.sh: /usr/bin/envsh: bad interpreter:
  No such file or directory
./main.sh: line 3: /tmp/external.sh: Success
```

The failure message is much clearer with `bash`.

## Conclusion

Shell scripts are still very popular because they are easy to write and use; unless the script fails. Then it becomes a hell of a job to debug if the script did not have good error handling in place to point you to the root cause of the failure. It’s very hard to debug because not all child calls give useful feedback to the user. Most scripts bail out on error and therefore rely on subscripts and programs to give good feedback.

Bottom line is if you don't need to support the old `sh` Bourne shell, prefer to use the more modern, user friendly and powerful `bash`. Happy scripting!
