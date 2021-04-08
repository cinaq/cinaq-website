---
title: Cloud Consultancy
url: "/services/cloud-consultancy"
date: 2021-04-05
description: Cloud consultancy services with focus on migrations, design and DevOps.
headerTransparent: true
sections:
- template: hero
  options:
    paddingTop: false
    paddingBottom: false
    borderTop: false
    borderBottom: false
    theme: primary
    classes: "my-custom-class another-custom-class"
  alignHorizontal: left
  alignVertical: middle
  height: 600px
  headings:
    heading: Cloud Consultancy
    subHeading: "Reaping the benefits of the cloud doesn't have to be hard."
    text: ''
  background:
    backgroundImage: "/media/charles-forerunner-3fPXt37X6UQ-unsplash.jpg"
    opacity: 1
    monotone: false
  image:
    image: ''
    shadow: false
    border: false
  buttons:
  - button: 
    url: /contact-us
    text: Reach out
    external: false
- template: info
  options:
    paddingTop: true
    paddingBottom: false
    borderTop: false
    borderBottom: false
    theme: base
    classes: ""
  align: left
  heading: Cloud Native
  description: Why wait for pages to build on the fly when you can generate them at
    deploy time? When it comes to minimizing the time to first byte, nothing beats
    pre-built files served over a CDN.
  image: https://source.unsplash.com/qtYhAQnIwSE/800x600y
- template: info
  options:
    theme: base-offset
  align: right
  heading: Mission Critical
  description: With server-side processes abstracted into microservice APIs, surface
    areas for attacks are reduced. You can also leverage the domain expertise of specialist
    third-party services.
  image: https://source.unsplash.com/OfwiURcZwYw/800x600
  buttons:
  - button: 
    text: Features
    external: false
    url: "/features"
  - button: 
    text: Blog
    external: false
    url: "/posts"
    theme: base-text
- template: info
  align: left
  heading: Cheaper, Easier Scaling
  description: When your deployment amounts to a stack of files that can be served
    anywhere, scaling is a matter of serving those files in more places. CDNs are
    perfect for this, and often include scaling in all of their plans.
  image: https://source.unsplash.com/VvAcrVa56fc/800x600
- template: grid
  options:
    theme: base-offset
  heading: Flexible card layouts and grids
  text: Inject different content types and display them in a grid. Choose different card layouts, customise the number of columns on both desktop and mobile. Limit the number of items and sort order.
  contentType: features
  sortBy: weight
  align: left
  limit: 4
  columns: 6
  columnsMobile: 12
  card:
    partial: card
    shadow: false
    border: false
    padding: true
    showTitle: true
    showDescription: true
    showDate: false
    showThumbnail: true
    showThumbnailLink: true
- template: content
  align: left
  columns: 8
- template: cta
  options:
    theme: primary
  heading: Kickstart your Hugo project
  description: Save days and weeks with our best practice templates.
  buttons:
  - button: 
    url: https://www.zerostatic.io/theme/hugo-paradigm/
    text: Buy Theme
    external: true
    theme: primary-offset
---

## Markdown Content

The markdown content can be placed between sections, not just at the end of the page. The markdown is still written like normal, it's not inside a front-matter field (which would be overly restrictive)