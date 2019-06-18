---
title: "Unlock Mac with Apple Watch stopped working"
date: 2019-06-17T13:37:00+01:00
draft: false
---

Occasionally my auto unlock Mac with Apple watch stops working. There are workaround instructions to "repair" this issue. One of them involves [rebooting both Mac and Apple Watch](https://www.macobserver.com/tips/quick-tip/apple-watch-stopped-unlocking-mac-fix/). Just like you I'm not very keen of rebooting my workstation. Deeper into researching I found the unlock feature relies on [Bluetooth and Wifi](https://blog.pcrisk.com/mac/12662-auto-unlock-with-apple-watch-not-working-how-to-fix).

So the following steps are needed to reset the auto unlock:

- Open *System Preferences*
- Go to *Security & Privacy*
- Go to *General*
- Uncheck *Allow your Apple Watch to unlock your Mac* (Step 1)
- Turn off *Bluetooth* and then turn it on again (Step 2)
- Turn off *WiFi* and then turn it on again (Step 3)

<center>
{{< figure src="/media/mac-apple-watch-system-preferences.png" caption="System Preferences" >}}
{{< figure src="/media/mac-apple-watch-menu-bar.png" caption="Mac Menu bar" >}}
</center>


After that turn on auto unlock again:

- Check *Allow your Apple Watch to unlock your Mac*

That's it! No need to reboot any device. This worked for me. Did this work for you?
