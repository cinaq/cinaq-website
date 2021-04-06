---
title: AppSec
url: "/appsec"
date: 2018-02-10T04:52:18.000+00:00
headerTransparent: true
sections:
- template: hero
  options:
    paddingTop: false
    paddingBottom: false
    theme: primary
  alignHorizontal: right
  alignVertical: middle
  height: 600px
  background:
    backgroundImage: "/media/mick-haupt-eQ2Z9ay9Wws-unsplash.jpg"
    opacity: 1
    monotone: false
  headings:
    heading: Mendix Application Security
    subHeading: A fully automated Mendix application scanner that helps you identify data compliance and privacy flaws.
  buttons:
  - button: 
    url: /contact-us
    text: Request a demo
  - button: 
    url: https://appsec.cinaq.com
    text: Open AppSec
    external: true
    theme: primary-text
- template: grid
  options:
    theme: base-offset
  heading: The weakest link is your business logic
  text: The Mendix platform and runtime component are continuously tested for security weaknesses. With AppSec you can also continuously ensure the business logic of your application is secure. Therefore freeing up time for your engineers to improve your business processes.
  contentType: appsec-features
  sortBy: weight
  align: center
  columns: 4
  limit: 6
  card:
    partial: card
    showTitle: true
    showTitleLink: false
    showThumbnailLink: false
  partial: card
- template: info
  options:
    paddingTop: true
    paddingBottom: true
    theme: base-offset
  align: left
  heading: Improve your Mendix Application Security
  description: Humans make mistakes. AppSec helps you identify those flaws before they are exploited by attackers.
  image: /media/appsec-process.png
  buttons:
- template: cta
  options:
    theme: primary
  heading: Are you sure your Mendix application is secure?
  description: Reach out to us to find out!
  buttons:
  - button: 
    url: /contact-us
    text: Request a demo
    theme: primary-offset
---