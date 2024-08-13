---
title: "A shortcut to owning an internal developers platform"
date: 2024-08-13T00:13:37+01:00
draft: false
tags: ["low-ops", "paas", "internal developer platform", "idp", "platform", "portal", "saas", "private idp"]
categories: ['Platform', 'Mendix']
authors: ['Xiwen Cheng']
description: Internal developer platform (IDP) is trending lately as it catches IT leaders’ attention. The quest for never-ending efficiency evolved from centralized sysadmin teams to decentralized DevOps, SRE and platforms. All with the ultimate goal to enable rapid value delivery. This is critical in today’s fast-paced world where time to market is crucial for business success.
thumbnail: '/media/fons-heijnsbroek-cCu6Knlzelo-unsplash-thumb.jpg'
image: '/media/fons-heijnsbroek-cCu6Knlzelo-unsplash.jpg'
---

Internal developer platform (IDP) is trending lately as it catches IT leaders’ attention. The quest for never-ending efficiency evolved from centralized sysadmin teams to decentralized DevOps, SRE and platforms. All with the ultimate goal to enable rapid value delivery. This is critical in today’s fast-paced world where time to market is crucial for business success.

What is an internal developer platform?
==

An IDP is like a town square where developers who own applications or want to own applications come together. Often, this place is a portal (internal developer portal) supported by a catalog listing and one or more app templates. The catalog enables others to discover the existence of apps and their APIs, while app templates enable new app owners to kickstart their app development at a rapid pace instead of ramping up in months.

Golden paths
==

In software development, teams often think their application is unique. While at its core that may be true, that mostly accounts for the tip of the iceberg of the time and effort teams spent on.
For most applications, they share a common foundation. The 80/20 percent rule is at play here as well. Where 80% of the time is spent on setting up boilerplate infrastructure, pipelines, monitoring, and so on. While these mostly deliver 20% of the value. This inefficiency can be solved by leveraging standardized golden paths. A proven setup that covers 80% of the work so that you can focus on the remaining 20%. The key here is that this 80% standardized configuration/setup is often fully automated.

What organizations benefit from IDP?
==

For most small or low-complexity organizations IDP is probably overkill. These organizations  are better off  setting up a single environment or leveraging  PaaS platforms like [Heroku](https://heroku.com), [Render](https://render.com), [Fly.io](https://fly.io), and similar, which address most of their infrastructure requirements already.

Any organization that either already has or aspires to have 10 or more apps can greatly benefit from an IDP, such as tech startups or businesses, and specially enterprises. This benefit increases when the number of apps reaches hundreds and thousands. With many apps built, a standardized infrastructure onboarding and workflow accelerates time to market, enables sooner and faster iterations, and encourages team members to switch projects because they do not need to spend months onboarding themselves in a new platform, and the workflow feels familiar despite a foreign project.

Types of IDP
==

There are many flavors of IDP. Here, we outline a few prominent types.

Portals: The most basic version is a portal that brings together different service capabilities under one hood. Examples are the [Backstage](https://backstage.io) from Spotify and the [Gimlet](https://gimlet.io). These provide a basic framework so that you can extend it as you please.

SaaS IDP: Growing more towards full service, there is the type of IDP that is offered as a SaaS, which deploys your apps directly into your own infrastructure. These often target public cloud service providers. Examples are the [Qovery](https://qovery.com) and the [Encore](https://encore.dev).

(Private) IDP: We believe IDPs should be, by definition, private and offer full-selfservice capabilities. This type is the best because you actually own your IDP and not merely rent it from a vendor. You remain in full control of your IDP and extend it if needed to fit your needs. An example is [Low-Ops](https://low-ops.com).

Getting your own IDP
==

There are many ways to get your own IDP. First, you have to choose the type that fits your organization.

If you have decided you need maximum control, you might want to roll your own. While building your platform can be fulfilling, keep in mind the initial development needed to get it off the ground and the continuous improvement and maintenance effort required to keep it working.

A better alternative is to acquire an off-the-shelf product so that you can hit the ground running. If you develop and deploy apps exclusively, we recommend you to try out the [Low-Ops platform](https://low-ops.com). It is an IDP you can install on top of a Kubernetes-compatible platform in less than an hour. You own the final platform fully.

Conclusion
==

Whether you plan to build a handful of apps or already have, it’s worthwhile to consider adopting an IDP to enable your engineering team to focus on adding value to your business, not re-inventing the wheel of infrastructure and DevOps.
You can decide to roll your own with the help of an existing portal or acquire a deeper integrated platform.
