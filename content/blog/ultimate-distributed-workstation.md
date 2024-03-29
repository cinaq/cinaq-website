---
title: "The ultimate distributed workstation setup"
date: 2022-10-05T13:37:00+01:00
draft: false
categories: ['Lifehack']
tags: ['syncthing', 'stignore', 'files', 'OSX', 'Synology', 'DSM', 'google drive', 'google workspaces']
authors: ['Xiwen Cheng']
description: Two-way synchronize files across different systems and against google drive for the ultimate distributed workstation experience.
thumbnail: '/media/luke-peters-rDxfSzXyBqU-unsplash-thumb.jpg'
image: '/media/luke-peters-rDxfSzXyBqU-unsplash.jpg'

---

For my multi-workstation setup, I often need my files synchronized across multiple devices. As you can imagine not all files must be synchronized across. To control that I use an ignore list similar to the `.gitignore` concept in git and there is a `git clean` command that removes untracked files. I needed that but for [Syncthing](https://syncthing.net/).

## Requirements

To explain my problem I will start with the context. My primary use case is that I want access to all my files at all times on different devices. The type of files are:

* Google files; I use google workspace for most of my work and personal files
* Lots of git repositories
* critical (encrypted) files

Since I tend to get ideas at weird random places and I prefer to use the tool/device best suited for the job I need access to my files on:

* Macbook with OSX
* Linux desktop for when I need bare Linux performance and focus
* Windows desktop for when I need bare Windows performance (Linux and Windows dualboots on the same desktop)
* Remote access on my iPhone and Ipad
* Use google workspace products

## Architecture

To accomplish the above the following architecture has been implemented:

![devices-syncthing-google-drive](/media/ha-workstations.jpg)

A few things to note are that my Macbook and desktops synchronize almost real-time against the syncthing server running 24/7 on my Synology NAS. The Synology in turn synchronizes against google drive every 5 minutes. Note that all synchronization paths are two-way.
Since Synology is online 24/7, it catches up in no time with google drive. This allows me to pack up my Macbook quickly and continue via google drive.

## Do not sync everything

As noted I have quite some git repositories. And a large part of them is nodejs backends or javascript frontends. As you might have seen it coming already: `node_modules`. They are big, have lots of files and consume quite some disk space, and are platform-dependent. As such there's no reason to synchronize them across to other devices/platforms. This is just one of the many examples of directories that should be excluded from this whole synchronization madness.

Over the years I have composed the following list kept in `.stglobalignore`:

* node_modules
* .DS_Store
* *.pyc

and many more (See appendix for full list)

This `.stglobalignore` file is also synchronized across to all devices. To really use this file, a `.stigore` file must be created by hand (if i recall correctly; haven't set up new device in a long time) with the following content:

```js
// .stignore
// 2
#include .stglobalignore
```

This trick was taken from [syncthing forum](https://forum.syncthing.net/t/is-there-a-stignore-file-that-will-be-synced-across-device/14905).

## Issues with DSM Cloud Sync

Last year I had issues with DSM Cloud Sync. This caused out-of-sync issues between my workstations and google drive. As I could not figure out what was wrong, I decided stop the Cloud sync job and synchronize from macbook to google drive using the Google Drive app on the Mac. To my surprise Google drive app does not have ignore list capability. It used to have it from what I read online. As such all my files that were supposed to be ignored from synchronization were uploaded to Google drive.

## DSM Cloud Sync is back in business

Recently there was a [new version of Cloud Sync that solves some synchronization issues with Google drive](https://www.synology.com/en-global/releaseNote/CloudSync). That looked interesting so I switched back. However, my files are now polluted with a lot of files that should be ignored. Thanks you Google!

## git clean for Syncthing

To clean up files from my Synology and Google drive, I created `clean.py` which reads in `.stglobalignore` file and finds all paths that match the patterns listed there. That list of files and directories is then presented to the user as confirmation before they are deleted.

An example run looks like this:

```bash
$ python ~/tools/clean.py
To be removed:
====
git/appsec/appsec/api/models/__pycache__/scan.cpython-39.pyc
git/appsec/appsec/api/models/__pycache__/audit.cpython-39.pyc
resources/.DS_Store
git/appsec/data
git/kubernetes/data
git/mx-foundation/live/foundation/vpc/.terragrunt-cache
Continue removal? YES/NO
```

this was run on the synology which propagates the removal to Google drive via Cloud Sync.

## Summary

It is possible to have two-way file synchronization across multiple devices allowing one to work with the files on the best-suited system or context with zero compromise.

Even-though computers are fast nowadays it's still crucial to do housekeeping on what files should be excluded from synchronization because this can have a significant impact on the synchronization performance. Before the cleanup of ignored files, my working copy was 14GB compared to 8GB after running `clean.py`.

## Appendix

### .stglobalignore

```js
// .stglobalignore

// Incomplete Downloads
// At least for now, these prevent Syncthing from transferring data that's
// going to be thrown out anyway once the download is finished and the
// file is renamed. Things may change when Syncthing gets smarter.
//
// Firefox downloads and other things
*.part
// Chrom(ium|e) downloads
*.crdownload

// Temporary / Backup Files
(?d)*~
(?d).*.swp
(?d)*.tmp
(?d)*.pyc
(?d)*.temp
(?d)*.sync-conflict-*

// OS-generated files (OS X)
(?d).DS_Store
(?d).Spotlight-V100
(?d).Trashes
(?d)._*

// OS-generated files (Windows)
(?d)desktop.ini
(?d)ehthumbs.db
(?d)Thumbs.db

// BTSync files
(?d).sync
(?d)*.bts
(?d)*.!Sync
(?d).SyncID
(?d).SyncIgnore
(?d).SyncArchive
(?d)*.SyncPart
(?d)*.SyncTemp
(?d)*.SyncOld

// Synology files
(?d)@eaDir


// Blacklisted dirs
/Moments
/Backup
(?d).tox
(?d).cache
(?d).mypy_cache
(?d)node_modules
(?d)/git/*/data
(?d).terragrunt-cache
(?d).tmp.drivedownload
(?d).tmp.driveupload
(?d)/git/*/dist
```

### clean.py

```python
import os
import glob
import shutil


with open(os.environ.get("IGNORE_FILE", ".stglobalignore")) as f:
    lines = f.readlines()

lines = [line.strip() for line in lines]

to_be_removed = []
for line in lines:
    if line.startswith("//"):
        continue
    if line.startswith("(?d)"):
        pattern = line.replace("(?d)", "**/")
    elif line.startswith("*"):
        pattern = "**/" + line
    else:
        pattern = line
    result = glob.glob(pattern, recursive=True)
    to_be_removed.extend(result)

print("To be removed:")
print("====")
for f in to_be_removed:
    print(f)

answer = input("Continue removal? YES/NO\n")
if answer == "YES":
    for f in to_be_removed:
        try:
            if os.path.isdir(f):
                shutil.rmtree(f)
            elif os.path.exists(f):
                os.remove(f)
        except:
            print("Failed to remove %s" % f)
```
