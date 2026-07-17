---
title: Home
date: 2021-04-04
description: "CINAQ is an IT company specializing in platform engineering, cloud consultancy, DevOps and SRE. We make private cloud as easy as public cloud."
sections:
- template: hero
  options:
    paddingTop: false
    paddingBottom: false
    borderTop: false
    borderBottom: false
    classes: 'hero-home'
    theme: base
  headings:
    heading: "Deploy apps to **private cloud** in minutes"
    text: "We build and run developer platforms that make shipping AI-era applications to private cloud and on-prem effortless — without compromising security, compliance or speed. If you love building apps, you will love working with us."
  height: auto
  alignHorizontal: left
  alignVertical: middle
  background:
    backgroundImage: ''
    monotone: false
    opacity: ''
  image:
    image: "/media/low-ops-platform-engineering.svg"
    overlap: false
    border: false
    borderRadius: true
    shadow: false
    altText: "Low-Ops Platform"
  buttons:
    - button:
      url: "https://low-ops.com"
      text: Explore Low-Ops
      external: true
    - button:
      url: "/contact-us"
      text: Talk to an engineer
      theme: base-text
- template: features
  options:
    paddingTop: true
    paddingBottom: true
    borderTop: false
    borderBottom: false
    theme: base-soft
  eyebrow: What we do
  heading: "Engineering that keeps your apps running"
  text: "From cloud strategy to hands-on platform operations, we help teams deliver software reliably and securely — at any scale."
  columns: 4
  features:
    - icon: fas fa-layer-group
      title: Platform Engineering
      text: "Internal developer platforms, golden paths and paved roads. We design, build and operate platforms your developers will actually enjoy using."
      url: /services/platform-engineering
      linkText: Learn more
    - icon: fas fa-cloud
      title: Cloud Consultancy
      text: "Migrations, architecture and cost optimization on AWS, Azure and Kubernetes. Reap the benefits of the cloud without the growing pains."
      url: /services/cloud-consultancy
      linkText: Learn more
    - icon: fas fa-shield-alt
      title: DevOps & SRE
      text: "CI/CD pipelines, observability, disaster recovery and security hardening. Mission-critical operations as a culture, not an afterthought."
      url: /contact-us
      linkText: Talk to us
- template: info
  options:
    paddingTop: true
    paddingBottom: true
    borderTop: false
    borderBottom: false
    theme: base
  align: left
  heading: "Low-Ops: your private cloud, batteries included"
  description: "Low-Ops is our platform product that helps organizations accelerate innovative solutions built with AI. Deploy any web app to private cloud or on-prem in minutes — with CI/CD, monitoring, backups and security built in from day one."
  image: /media/platform-engineering.svg
  buttons:
  - button:
    url: "https://low-ops.com"
    text: Visit low-ops.com
    external: true
- template: info
  options:
    paddingTop: false
    paddingBottom: true
    borderTop: false
    borderBottom: false
    theme: base
  align: right
  heading: "MxLint: quality gates for low-code"
  description: "Our open-source linter brings automated code review, security checks and CI quality gates to low-code development teams. Catch issues before they reach production."
  image: /media/appsec-report.png
  buttons:
  - button:
    url: "https://mxlint.com"
    text: Discover MxLint
    external: true
- template: grid
  options:
    paddingTop: true
    paddingBottom: true
    borderTop: false
    borderBottom: false
    theme: base-soft
  heading: "From the blog"
  contentType: blog
  sortBy: date
  sortOrder: desc
  limit: 3
  columns: 4
  card:
    showThumbnail: true
    showDate: true
    showTitle: true
    showDescription: true
  button:
    url: /blog/
    text: Read all posts
    theme: base-text
- template: cta
  options:
    paddingTop: true
    paddingBottom: true
    borderTop: false
    borderBottom: false
    theme: primary
  heading: "Let's build something reliable together"
  description: "Tell us about your stack, your team and your goals. We will get back to you within 24 hours."
  buttons:
  - button:
    url: /contact-us
    text: Get in touch
---
