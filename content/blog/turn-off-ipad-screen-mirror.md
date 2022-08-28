---
title: "Mysterious Ipad screen mirror app detected by PSI Secure browser"
date: 2022-08-28T13:37:00+01:00
draft: false
categories: ['OSX', 'Exam']
tags: ["mac", "PSI", "osx", "apple", "ipad", "ipad screen mirror", "screen mirror", "stress"]
authors: ['Xiwen Cheng']
description: When you're late for your exam, the last thing you want is the exam program complaining about some phantom app that must be terminated.
thumbnail: '/media/jeshoots-com--2vD8lIhdnw-unsplash-thumb.jpg'
image: '/media/jeshoots-com--2vD8lIhdnw-unsplash.jpg'

---

> If you're in a rush for the solution, jump to the bottom of this page.

Recently I had my CKS (Certified Kubernetes Security Specialist) exam via the PSI platform. A few weeks earlier when I scheduled the exam I made sure to run the system check because I had troubles with these in the past with my macbook (OSX). I don't recall which exam platform it was.

10 minutes before the scheduled exam I opened the PSI portal to start the check-in process. To my surprise, I had to install the PSI Secure Browser program. At first, I thought it was no big deal. Then I got stuck on the Security check phase where it claims I have an application active called **ipad screen mirror**.

I tried:

- Pressing the **Terminate all apps** button which killed all apps with the exception of this **ipad screen mirror** app
- find it in the force close dialog and the activity app. Could not identify the process for termination
- Then I realized I tried iPad as an external monitor in the past. So tried turning off my iPad completely. That did not help
- There's no way to break the link in the Display section of **System Preferences**.
- As a last resort, I rebooted the macbook. That also didn't help.
- Obviously, I also tried looking for answers on Google without any luck. All results were related to **ipad screen mirroring**. Not even if I include **"PSI"** in the query.

## Solution

As I ran out of ideas and I was 20 minutes late for my exam already, I decided to call PSI support. 5 minutes in I managed to speak to technical support. Following the standard procedures from the friendly support engineer we accidentally found the solution:

- Turn off bluetooth
- Reboot
- Relaunch the exam

(I suspect above was the solution, didn't get a chance to double check it cause I was running late for my exam)

At 40min late, I finally got through the security check. The proctor (PSI) didn't refuse me and I finally started my exam 1 hour later than planned.

Hope this is useful to others in the future and takes away some stress.
