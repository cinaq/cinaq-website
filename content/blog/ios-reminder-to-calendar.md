---
title: "The missing link between Reminders and Calendar app on iOS"
date: 2022-11-22T13:37:00+00:00
draft: false
categories: ['Productivity', 'Automation']
tags: ["ios", "reminders", "calendar", "productivity", "low-code"]
authors: ['Xiwen Cheng']
description: The native productivity tools on iOS is great. They work seamlessly with Apple's ecosystem. Except for reminders and calendar app.
thumbnail: '/media/towfiqu-barbhuiya-jOeh3Lv88xA-unsplash-thumb.jpg'
image: '/media/towfiqu-barbhuiya-jOeh3Lv88xA-unsplash.jpg'

---

My obsession to live by my calendar meant I was always on the lookout for optimizing my agenda workflow. The Apple ecosystem works very nicely together. And don't forget the fact usability is top-notch and well-thought-out. My quest to find the perfect productivity setup has come full circle: started with Apple apps, tried many third-party tools, and finally, we are back to square one with Apple apps. But now with a tiny modern enhancement.

## Quick start

Since the publishing of this article there have been a few visitors that had trouble setting up their own synchronization. In this section help you get started as quickly as possible.

### Prerequisites

- Reminders list name: this is the name of your reminders list. It also must match with your calendar name. 
- Import [Reminders2Calendar](https://www.icloud.com/shortcuts/af92df99d9d149c0ab74d59aee491cb7) into your shortcuts on your iPhone.

### Setup single list

- Open Shortcuts.app
- Create a new shortcut. I call it **Reminders2Calendar Personal**
- in this new shortcut add 2 actions so that it looks like. **Personal** is my Reminders list:
![Reminders2Calendar Personal](/media/reminders2calendar-personal.png)

Repeat this procedure if you have multiple lists.

### Synchronize all

Personally I have 2 lists I need to synchronize. To simplify the automation we can group them into a master shortcut called **Reminders2Calendar ALL**:
![Reminders2Calendar ALL](/media/reminders2calendar-all.png)

### Triggers

Now you can call this master shortcut based on triggers:

![Time based trigger](/media/reminders2calendar-time-based.png)
![event based trigger](/media/reminders2calendar-event-based.png)


# Backstory

In case you're interested in the story behind this tool checkout the rest of this article.

## The Contenders

For a long time, I have used the [Calendars 5](https://apps.apple.com/nl/app/calendars-5-by-readdle/id697927927) app together with [Spark mail](https://apps.apple.com/nl/app/spark-mail-smart-email-inbox/id997102246). They are fantastic products that work very well. These were the first apps I ever decided to buy in Apple Appstore. Why? Because they really increased my productivity.

Some Spark advantages:

- Magically syncs account across devices
- Includes an extra pane for Calendar
- integrates with conference call tools like Google meet

There are many more, but these are my highlights.

With regard to Calendars 5, the advantages are:

- works with native ios reminders and calendars
- shows reminders/tasks in the same calendar view

Both apps have pretty good UX.

## Triggers

Recently there were a few changes that forced me to look around.

The first Spark has released a new version that added Spark signature to all outgoing emails unless you pay for a subscription. As a long-time, early adopter, I paid for the product many years ago. Understandably Readdle Technologies (publisher) is finding ways to increase its revenue. This attempt caused many [early adopters to shop for an alternative](https://forums.macrumors.com/threads/popular-email-client-spark-gets-major-redesign-for-mac-moves-to-subscription-model.2363830/page-11). A few weeks after that release, Readdle decided to remove this signature for early adopters. That's nice of them but the damage has already been done.

Second, with the new releases of iOS (15 and 16), the widget of Calendars 5 often does not display the events. I'm not sure what exactly causes the bug. But reboot solves the problem. However, I'm not the type that reboots the phone regularly. This contributed greatly to the ongoing irritations.

## Back to good old Apple

I often fantasized about going back to an Apple-only productivity suite because the UX of these apps is unbeatable. Reminders and calendars are synced across all devices seamlessly. Why is this important?

- I can add reminders while at the gym doing bench presses or swimming. I do reflections during those sessions and sometimes I get great ideas during a workout.
- On the go with Apple Watch or iPhone I get access to my agenda
- Need more planning freedom? Open up Macbook
- Driving in the car? Access via Carplay

The UX of Apple Reminders, Mail and Calendar app are not as feature-rich as Readdle suite. But UX is pretty damn good. However, there is one issue:

> Reminders and Calendar events are not connected in any way.

It kinda makes sense but at the same time, it doesn't. Because Reminders is essentially a few lists of to-do items. However, a task can have a deadline. When the deadline is defined, why wouldn't Apple use this information and show it in Calendar app?

## Reminders2Calendar

A few years ago [Apple acquired Workflow app](https://en.wikipedia.org/wiki/Shortcuts_(app)). It has been rebuilt and rebranded into Shortcuts app which is now included in iOS. As an automation fanboy, by profession and privately, I started exploring the capabilities of the Shortcuts app. There are currently few shortcuts that automate my workflows at home and on the go.

With my adventure going back to Apple-only ecosystem, I have identified the biggest blocker:

> reminder tasks are not shown in my calendar. I want a single list, my agenda, to guide me through the day.

To take ownership of my problem, I came up with a solution. It uses shortcuts app to automate pushing relevant reminder tasks to calendar as events. The pseudo-code looks like:

```

todos_with_deadlines = get_reminders(completed=false, from=today, to=7days_from_now)

foreach todo in todos_with_deadlines:
  upsert_calendar_event(todo)

completed = get_reminders(completed=true, from=7days_ago, to=today)
foreach task in completed:
  update_calendar_event(task)

```

After a few days of tinkering and doing low-code on the phone I have finally reached the final version of [Reminders2Calendar](https://www.icloud.com/shortcuts/af92df99d9d149c0ab74d59aee491cb7).

{{< rawhtml >}} 

<video controls autoplay>
    <source src="/media/reminders2calendar.mp4" type="video/mp4">
    Your browser does not support the video tag.  
</video>

{{< /rawhtml >}}

## Automate synchronization

In above video, you can see me running a shortcut by hand. [That shortcut is a wrapper](https://www.icloud.com/shortcuts/8994e764a7cf4b88835896857ce30598) that enables me to push multiple Reminder lists to Calendars.


## Conclusions

As you can see, with a little automation help we can make our lives more productive. Now we get more benefits from the Apple products. I've removed the Readdle product suite from my systems and I'm now fully back on Apple. Hopefully one day Apple decides to implement this automation workflow into its native products.
