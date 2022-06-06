---
title: "Is the Mendix Basic Package for me?"
date: 2022-06-04T00:13:37+01:00
draft: false
tags: ["mendix", "book", "mendix-ops-book", ]
categories: ['Cloud', 'Mendix']
authors: ['Xiwen Cheng']
description: The free tier is not sufficient for your application? Or you are considering to use Mendix for your startup? In this article to shed some light on the Mendix Basic Package.
thumbnail: '/media/mendix-basic-header-thumb.png'
image: '/media/mendix-basic-header.png'
---

Mendix introduced the Basic package back in [September 2021](https://www.mendix.com/blog/how-to-kickstart-your-app-with-mendix-basic/). It has been one of the most anticipated moves around licensing because there were Free apps, the free tier which mostly enabled hobby projects or newcomers to try out Mendix. The second option was simply: enterprise sales.

With the Basic Package, Mendix tries to close the gap between free and enterprise. Which as you might have guessed would be small businesses, more demanding hobby projects, or startups. In practice, this classification turns out to be non-trivial as asked [on Mendix Forum](https://forum.mendix.com/link/questions/110291). Or quoting a recent conversation on Mendix Community slack:

> Have you guys thought about Mendix's Basic package as a way of testing a web app idea on the market? Well, don't...

This article will try to help you decide whether the Basic package is right for you. We will also explain why this decision is so important.

## Audience

With this article, we hope to help those considering or who have been using the Mendix basic package. This affordable package is paid one year upfront. Depending on your situation this can be a significant investment. Therefore the main target audience is startups, small teams/businesses, and amateur/professional Mendix developers looking to upgrade from the free tier.

## Pricing models

Like most things we purchase, the price is very important for our decision-making process. For starters, you can build your app and run it for free using the free tier. The next level is basic which starts from 50 euro/month. The third is the Standard package which starts from 800 euro/month. And finally, there is  Premium for which a quote must be requested.

![Mendix Pricing](/media/mendix-pricing.png)

The free tier is suitable for low requirements use cases or demos. For example a members portal for your local soccer club. Or manage the inventory at a small florist shop. Because it’s free, there is no customer support unlike the rest of the packages. It’s also great for classes or practice environments.

If the availability of your app is important, you might need at least the basic package. You have more control over backups, access to monitoring services and receive support when needed. It is the first package you could depend on concerning business continuity.

In short, the standard package is for more complex applications that require scaling the infrastructure for performance. Best suited for medium-sized businesses. Also great for Software as a Service (SaaS) application types due to its low cost per user. However, the steep base price of 800 euros per month is probably not affordable for most starters.

If you are an enterprise planning to create more than 5 Mendix apps, reach out to the Mendix sales team for a quote.

Check the [official pricing page](https://www.mendix.com/pricing/) for full details.

## The Basic package

The Basic package is technically fairly [well documented](https://docs.mendix.com/developerportal/deploy/basic-package/). However, there is more to it than just technical capabilities. We hope to help you look at this package from two viewpoints: strategic and use-case oriented. Nonetheless, the technical specifications are still relevant and we can sum them up as:

* Runs in the Mendix Cloud
* Supports between five and a hundred (5-100) users
* Has a limited amount of resources and a single cloud environment on Mendix Cloud V4
* 1GB App RAM
* 0.25 vCPU which is fairly low but enough for small apps
* 1GB database schema as a part of a shared database
* 10GB file storage for FileDocument and Image entities [according to official docs it's 1GB](https://docs.mendix.com/developerportal/deploy/basic-package/) but [another blog article states it's 10GB](https://www.mendix.com/blog/how-to-kickstart-your-app-with-mendix-basic/) also the basic plan details claim 10 GB.
* Regular Platform SLA
* Backups allow you to recover from accidents
* (partial) Metrics and alerts

The main advantage of the Basic package over free apps is the fact your app doesn't go to sleep when there's no activity.

### Application overview

Basic grants you access to a single production environment.
![Mendix Basic application overview](/media/mendix-basic-application-overview.png)

### Environment details

The production environment can be configured with a custom domain. A must-have for any business.
![Mendix Basic environment details](/media/mendix-basic-environment-details.png)
![Mendix Basic Plan](/media/mendix-basic-specs.png)

## It barely handles 4 users

When it comes to how many users your application can handle it's a very complicated discussion. From a marketing perspective, the pricing model does allow 100 users based on the licensing. However, the other specifications, namely technical in this case, do not give that guarantee. That's because it depends on how the application is built.

On Mendix community slack there was a thread:

> Have you guys thought about Mendix's Basic package as a way of testing a web app idea on the market? Well, don't...  What's sold as a platform for up to 100 users barely manages 4.

Leading to this thread, I did an investigation with the original poster to find out why this SaaS application is so slow. The performance issues were the result of the complicated use case. There were over 50 entities with complex relations of which some entities have thousands of rows. There was this requirement to keep old data around. Also because this app was a multi-tenant app, it makes all the queries much more complicated implicitly.

Also considering the fact:

> There's no step between the €50/month and the €800/month plans (talk about scalability...)

It's important to design and build your application as efficiently as possible. The rule of thumb here is to keep it simple. The more complicated your domain model, the more likely it is you are going to run into performance issues. Needless to say, the basic package is sufficient in most cases to handle 100 users assuming the working dataset is small to a modest size.

## Caveats

Besides the steep upgrade cost from the Basic Package onwards, the main caveat with the Basic package is the shared database. Since the database server is not dedicated to your application alone, you're susceptible to noisy neighbor issues. This means that if there is a bad tenant (other customers of Mendix) that consumes all the database resources, your application performance will be impacted negatively. Due to this shared nature, you don't have insight into the overall database performance metrics. So it becomes harder to reason about database performance with quantifiable metrics.

## Performance improvements

There are a few pieces of advice to help remediate performance issues. In this section, we outline a few tips and tricks. These are very important for apps running the Basic Package due to low-budget system specifications. Nonetheless, they are still very much applicable to other packages when your app is suffering from performance issues.

### Simplify domain model

Especially when your app is a multi-tenant all queries become heavier on the database. With multi-level entity relationships queries becomes significantly more expensive to execute especially when some intermediate join tables contain a large number of rows. Keeping your domain model simple, often demands fewer resources from your database.

### Retrieve fewer objects

Mendix makes it easy to manipulate and filter objects within Microflows. However, you should consider leveraging the database as much as possible by using its querying capabilities and returning the minimum objects required for the task at hand. If not, your application runtime may not be able to handle/process a large amount of data in memory. The 1GB memory capacity might sound a lot, but in low-code platforms like Mendix, memory efficiency is quite low at the expense of ease of use.

### Experiment with indices

If your queries are slow, adding indices to columns could help speed up the retrieval. However, mutations will be more expensive (slower). So be careful with indices. In Mendix it's easy to add and remove indices without data loss. You should feel comfortable experimenting.

### Move infrequently accessed data to a separate entity

Depending on your use case, sometimes not all data is equally important or relevant to consider for the common use cases. If your application needs to keep old records for compliance reasons, you can consider moving these old records into a separate archive entity isolating them from the working set of data. This can be achieved with a scheduled event that archives old data. It reduces the strain on the database by having to deal with archived data regularly while it's not needed.

## Upgrade as a last resort

If all the optimization efforts don't yield an acceptable performance for your application it's time to consider upgrading your cloud environment specs. Whether to upgrade the application runtime or database depends on the bottleneck. A good rule of thumb is if your application regularly crashes due to out-of-memory, increase the application runtime memory. If your queries are slow and you can confirm the database size is larger than the memory capacity allocated to your database, upgrade the database with more memory and CPU.

Upgrading from the Basic Package is a last resort remediation action because the next package is standard which is a whopping 1600% cost increase (800/50 * 100). Unless you can conclude your growth is more important than optimizing your current solution upgrading shouldn't be your first choice.

## Conclusions

In conclusion, the Basic package is a nice addition for small businesses with relatively simple domain model requirements. If you are planning to use this for (micro) SaaS solution, you must keep a check on domain model complexity and amount of data. Perhaps be prepared to upgrade to the Standard Package at any time.