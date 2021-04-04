---
title: Custom Page Example 1
url: "/photography"
date: 2020-03-22
description: Design Websites In Minutes. Fast, secure and easy to maintain
headerTransparent: true
sections:
- template: hero
  options:
    paddingTop: false
    paddingBottom: false
    theme: base
  alignHorizontal: right
  alignVertical: middle
  height: 500px
  background:
    backgroundImage: "/images/pages/jean-philippe-delberghe-75xPHEQBmvA-unsplash-3000.jpg"
    opacity: 1
    monotone: false
  headings:
    heading: Build custom pages
    subHeading: Design the page layout using front-matter blocks.
- template: content
  options:
    paddingTop: true
    paddingBottom: true
  columns: 9
---

{{< gallery dir="/photographs/" />}} {{< load-photoswipe >}}
