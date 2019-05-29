---
title: "Debug shell script error: not found"
date: 2019-05-29T00:13:37+01:00
draft: false
---

# Introduction

Automation engineers often have boring tasks. Their job is to automate repetitive tasks. In the early days of Unix and Linux most automation is done with shell scripts. Nowadays we use higher level configuration management systems like [Ansible](https://www.ansible.com/), [Puppet](https://puppet.com/), [Salt](https://www.saltstack.com/), etc replacing most of the erroneous scripts with poor error handling, lots of boiler code and more importantly high maintenance cost.

Even though we have these fantastic tools we often fall back to shell. It’s still the favorite method of quickly drafting a script improving our efficiency. Also shell scripts are reasonably portable without dependency on some tools that might be absent; every Linux system is shipped with a shell. Since it is so easy to create and use them, shell scripts are still widely used.

# Poor feedback from shell script

As pointed out earlier error handling is often minimal in shell scripts. This is a natural consequence because scripts focusses being short. Therefore happy case is the only use case supported. Error handling relies on the child tools/processes to give useful feedback on error.

A simplified case is as follow.

We have our entry-point script called `main.sh` containing:

{{< highlight shell >}}
#!/usr/bin/env sh

exec ./external.sh
{{< /highlight >}}

And our `external.sh` contains:
{{< highlight shell >}}
#!/usr/bin/envsh

echo Hello $0
{{< /highlight >}}

Create these files on your system and make them executable so that you can run them:
{{< highlight shell >}}
chmod +x main.sh
chmod +x external.sh
{{< /highlight >}}

Running the script `./main.sh` fails with:
{{< highlight shell >}}
./main.sh: 3: exec: ./external.sh: not found
{{< /highlight >}}

First reaction is: what does this mean?

`exec` function is complaining about `./external.sh` cannot be found. At least that was my initial interpretation. However that does not make any sense because `./external.sh` script does exist. That is very confusing.

# Debugging with `strace`

[Strace](https://linux.die.net/man/1/strace) is diagnostic utility for Linux. Let's use it to debug our original program. The result of `strace ./main.sh` looks like:

{{< highlight shell >}}
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
{{< /highlight >}}

It doesn't give us any new information. Still a confusing error message.

# Manual debugging

How about we run `./external.sh` ourselves?
{{< highlight shell >}}
bash: ./external.sh: /usr/bin/envsh: bad interpreter:
  No such file or directory
{{< /highlight >}}

Aha! There was a typo in the interpreter path on the [shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) line. That resulted in a rather cryptic error message. Fixing the shebang typo to `#!/usr/bin/env sh` in `./external.sh` our main script works:

{{< highlight shell >}}
Hello ./external.sh
{{< /highlight >}}

# Use `bash` as alternative

Let's change our shell interpreter from [Bourne Shell](https://en.wikipedia.org/wiki/Bourne_shell) to [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) in `main.sh`:

{{< highlight shell >}}
#!/usr/bin/env bash

exec ./external.sh
{{< /highlight >}}

Now the error message is:

{{< highlight shell >}}
./main.sh: /tmp/external.sh: /usr/bin/envsh: bad interpreter:
  No such file or directory
./main.sh: line 3: /tmp/external.sh: Success
{{< /highlight >}}

The failure is much more clear with `bash`.



# Conclusion

Shell scripts are still very popular because they are easy to write and use; unless the script fails. Then it becomes a hell of a job to debug if the script did not have good error handling in place to point you to the root cause of the failure. It’s very hard to debug because not all child calls give useful feedback to the user. Most scripts bail out on error and therefore rely on subscripts and programs to give good feedback.

Bottom line is if you don't need to support the old `sh` Bourne shell, prefer to use the more modern, user friendly and powerful `bash`. Happy scripting!
