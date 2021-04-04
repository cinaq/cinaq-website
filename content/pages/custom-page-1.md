---
title: Custom Page Example 1
url: "/custom-page-1"
date: 2020-03-22
description: Design Websites In Minutes. Fast, secure and easy to maintain
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
  height: 700px
  headings:
    heading: Design Websites In Minutes
    subHeading: Fast, secure and easy to maintain.
    text: ''
  background:
    backgroundImage: "/images/pages/lance-anderson-GOK4iscFSkA-unsplash-2000.jpg"
    opacity: 1
    monotone: false
  image:
    image: ''
    shadow: false
    border: false
  buttons:
  - button: 
    url: /custom-page-2
    text: Learn More
    external: false
  - button: 
    url: "https://www.zerostatic.io/theme/hugo-paradigm/"
    text: External Link
    external: true
    theme: primary-text
- template: info
  options:
    paddingTop: true
    paddingBottom: false
    borderTop: false
    borderBottom: false
    theme: base
    classes: ""
  align: left
  heading: Better Performance
  description: Why wait for pages to build on the fly when you can generate them at
    deploy time? When it comes to minimizing the time to first byte, nothing beats
    pre-built files served over a CDN.
  image: https://source.unsplash.com/qtYhAQnIwSE/800x600y
- template: info
  options:
    theme: base-offset
  align: right
  heading: Higher Security
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