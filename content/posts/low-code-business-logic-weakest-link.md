---
title: "Your business logic is the weakest link in Low-Code security"
date: 2020-08-09T13:37:00+00:00
draft: false
categories: ['Mendix', 'Security', 'AppSec']
tags: ["mendix", "low-code", "security", "productivity"]
authors: ['Xiwen Cheng']
description: The low-code movement is gaining traction. Low-code platforms enable citizen developers to create applications that solves real world challenges. However these applications are at risk due to weak security or inadequate data handling logics.
thumbnail: '/media/sigmund-elHKkgom1VU-unsplash.jpg'
image: '/media/sigmund-elHKkgom1VU-unsplash.jpg'
aliases:
  - /post/2020/08/09/your-business-logic-is-the-weakest-link-in-low-code-security/

---

Over the past 5 years [interest in low-code increased 100 folds](https://trends.google.com/trends/explore?date=2015-01-01%202020-08-02&q=%2Fg%2F11c6cx4nrr) according to Google Trends:
![Low-code development trends](/media/low-code-trends.png)
This correlates with human psychology eager to optimise for efficiency in everything and building software solutions is no exception. As programming is becoming easier and more accessible, in the future, anyone should be able solve their own information automation challenges. Low-code is a relatively new movement that tries to enable those citizen developers with the right tooling lowering the barrier to build applications without writing traditional code. Because most of my professional experience with low-code is around [Mendix](https://www.mendix.com), I will use it as reference through out this article.

## Low to high level

First computer programs were written in machine code by few experts in the early days. This programming ability felt like a super power to many. Just like the Industrial age boosted the human civilisation, the Information Technology age we are currently in is helping the human race reach new heights. Programming languages are invented or improved to enable more efficient or better programming paradigms. This trend in [programming languages timeline](https://en.wikipedia.org/wiki/History_of_programming_languages) is recently leading towards visual programming. In the industry this idea is marked as [low-code platforms](https://en.wikipedia.org/wiki/Low-code_development_platform). To me this is currently the highest programming level because of its high productivity characteristics. Low-code is in a nutshell an unification of deployment and composable building blocks nicely packed to play well together reducing the feedback loop at development and runtime.

## Abstraction penalty

The cost of higher abstraction which often correlates with higher productivity is [Abstraction penalty](https://en.wikipedia.org/wiki/High-level_programming_language#Abstraction_penalty). As we move up in the pyramid depicted below, we accomplish more with fewer efforts. That little effort however translates to more execute computing instructions. Due to this fact we loose optimisations and also unaware of the extra assumptions made in between. This problem increases more as applications grow larger and depend on libraries. No matter how well documented the libraries are, they are again abstractions of the actual implementation which might be inaccurate or the user of such library might not know or understand the full extends of the functionalities being leveraged on.

![Higher programming languages result in higher computational instructions count](/media/low-code-productivity-pyramid.png)

## Security

A critical aspect of abstraction penalty is the unawareness of implied behaviours. Citizen developers (Low-code developers) leverage a lot from low-code platform itself; often with insufficient experience and knowledge of the underlaying runtime environment. This is a natural cause because these platforms were designed and promoted  for easy adoption. In the case of Mendix a typical security pitfall is negligence of [entity access on attributes level](https://docs.mendix.com/refguide/access-rules). Developers often focus on getting the program to work, in this particular case, a developer would grant access to all users. No matter the seniority, people make mistakes and forget access rule must be refined. In low-code platform like this, it’s very easy to make mistakes and leave open major security holes.

Platforms like Mendix already has [security covered very well](https://www.mendix.com/evaluation-guide/enterprise-capabilities/security). However with a strong platform, you can still build vulnerable applications because the platform does not know or understand your data risk levels. Therefore the weakest link is your business logic on a low-code platform.

![Business logic is weakest link with Mendix](/media/low-code-mendix-security.png)

A typical example is: developer gives all access to credit card number attribute in the application model. The developer makes a remark to fine tune the access rules later but forgets to do so. Due to time pressure, testers mostly focussed on the happy use cases which did not reveal the CC information leak.

Therefore it’s crucial to have tooling to help detect these mistakes before they hit production. A tool that could reveal more that meets the eye for developers and testers alike. In Mendix, this would mean bypass the View (from [Model View Controller](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)) showing all accessible data and function calls for a given user. There are few challenges here:
- How to extensively and automatically collect these data
- How to make sense of the collected data to identify security weaknesses
- Finally a repeatable and preferably incremental method to assess the security risk coverage

Often pentest consultants are called in to assess the security risks of low-code applications. However this process is very labor intensive and error prone. As pointed out, higher generation languages like low-code has a bigger attack vector (related to number of computational instructions together with rapid feature building) requires extensive manual work.

## Conclusions

In this article we learned low-code is an upcoming trend and it helps companies innovate faster by increasing the productivity of its developers. However, with the higher abstraction levels, it’s also easier to make security mistakes leaving the application vulnerable to attacks. As the citizen developers group grows, we need tooling in place to help identity security risks with the same low threshold as it requires to develop an app on a low-code platform.
