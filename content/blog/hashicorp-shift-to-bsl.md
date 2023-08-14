---
title: "HashiCorp's Shift to BSL v1.1 and its Effect on PaaS"
date: 2023-08-14T00:13:37+01:00
draft: false
tags: ["hashicorp", "low-ops", "bsl", "mpl", "license", "paas"]
categories: ['Platform', 'Mendix']
authors: ['Viktor Berlov']
description: Hashicorp products license shift from MPL to BSL, what does it mean for companies that develop their PaaS products integrated with Terrafrom, Vault, Consul, etc.
thumbnail: '/media/license-thumb.jpg'
image: '/media/license.jpg'
---

As of August 10, HashiCorp made an important [announcement](https://www.hashicorp.com/blog/hashicorp-adopts-business-source-license) regarding a significant shift in its licensing strategy. The transition from the Mozilla Public License 2.0 (MPL 2.0) to the [Business Source License version 1.1 (BSL v1.1)](https://www.hashicorp.com/bsl) has generated considerable [discussions](https://news.ycombinator.com/item?id=37081306) and anticipation within the technology community. In this post, we aim to shed light on the implications of this change, not only for our team but also for companies like [heroku](https://www.heroku.com), [fly.io](https://fly.io), [render.com](https://render.com) that utilize or consider using HashiCorp's products in their PaaS.


##  Why it's happening?

In the current landscape, we are witnessing a surge in highly integrated service providers offering Open Source products tailored as comprehensive services. An illustrative case in point is Amazon's transformation of Elasticsearch into a commercial offering known as Amazon Elasticsearch Service (Salil Deshpande analyzed this in detail in the [post](https://techcrunch.com/2019/05/30/lack-of-leadership-in-open-source-results-in-source-available-licenses/)](https://techcrunch.com/2019/05/30/lack-of-leadership-in-open-source-results-in-source-available-licenses/)). This shift has reverberated across the industry, prompting other enterprises that fostered Open Source (OOS) database distributions, like MariaDB and CockroachDB, to pivot towards the Business Source License version 1.1 (BSL v1.1). The outcomes of this shift have led to a recalibration in product usage, particularly within the realm of Database-as-a-Service (DBaaS) offerings.

## What does it mean for PaaS solutions?

HashiCorp's decision to transition its licensing structure might carry weight for those who rely on its products for building application platforms. Let’s take a closer look at what this change means to your PaaS. This prompts us to evaluate how this change aligns with our approach and commitment to delivering a top-notch platform as a service solution.

As outlined in [HashiCorp's FAQ](https://www.hashicorp.com/license-faq): organizations offering rival solutions to HashiCorp's products will no longer have the privilege of accessing community edition products free of charge under the BSL license. This development carries specific implications for teams crafting Platform-as-a-Service (PaaS) offerings integrated with HashiCorp's tools. It's essential to note that such integrations and embeddings do not breach the license unless they cross the threshold of commercializing HashiCorp's code as a standalone service.

## Why It Matters?

In our journey to creating a powerful and user-friendly platform, licensing considerations hold a pivotal role. A well-thought-out platform demands meticulous effort and strategic decisions, and these decisions could significantly impact our business landscape. It's prudent to recognize that licenses are subject to change over time, underscoring the importance of making careful license considerations before integrating a specific product or tool into our platform ecosystem.
Here are some key considerations that we are focusing on:

- License Compliance for Clients: Ensuring that our clients are compliant with the evolving licensing terms is of utmost importance. Open communication and transparency are vital in this regard.
- Client Expectations and Agreements: Addressing any shifts in licensing terms with our clients is essential to maintaining a trusting and mutually beneficial relationship.
- Long-Term Strategy: The evolving licensing landscape prompts us to assess the long-term alignment of our platform's roadmap and strategy.
- Exploring Alternative Solutions: We remain open to exploring alternative solutions that align with our platform's goals while respecting the evolving licensing framework.

[Low-ops](https://low-ops.com) platform integrates several HashiCorp products to establish a robust foundation. Terraform is instrumental in building this foundation, while Consul and Vault enhance its capabilities by offering secure storage and management of sensitive data. These products synergize to create an environment that fosters fast and efficient [Mendix](https://www.mendix.com) application development and deployment.
As we plan for future platform upgrades, we emphasize ensuring that our platform components remain secure, up-to-date, and equipped with the latest features and security patches. These considerations align with our strategy of consistently delivering optimal performance and user experience to our clients.

## Our Position

We have contacted HashiCorp’s legal department to ensure that our interpretation of BSL v1.1 is correct and, after clarifying our usage of their products and [Low-ops](https://low-ops.com) purpose, we promptly received a positive reply.
It's worth noting that the HashiCorp products integrated into the [Low-ops](https://low-ops.com) platform are utilized as internal implementation details, serving to enhance our platform's performance and capabilities. Importantly, these integrations are not positioned as direct competitors to HashiCorp's offerings, meaning that we uphold the guidelines set forth by the BSL v1.1 license.

> **Disclaimer**: This blog post is intended for informational purposes only and does not constitute legal advice. The information provided is based on the situation as of the publication date.
We remain committed to delivering a powerful and compliant platform experience, and our approach will continue to be guided by the best interests of our clients and partners.
