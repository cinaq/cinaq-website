---
title: "{{ replace .TranslationBaseName "-" " " | title }}"
date: {{ .Date }}
draft: true
description: "Design Websites In Minutes. Fast, secure and easy to maintain"
image: "/images/bantersnaps-5U_28ojjgms-unsplash-2000.jpg"
headerTransparent: true
sections:
- template: hero
  options:
    paddingTop: false # true/false
    paddingBottom: false # true/false
    borderTop: false # true/false
    borderBottom: false # true/false
    theme: primary # "base", "base-offset", "primary", "primary-offset" - Uses color variables from `data/themes.json` to theme the section
    classes: "custom-hero-section super-hero" # "my-class my-class-2" - Add custom classes to the section div for custom CSS styling
  alignHorizontal: left # "left", "right" - Aligns the text and image 
  alignVertical: middle # "top", "middle", "bottom" - Aligns the text and image 
  height: "800px" # "600px", "auto" - Specify a height for the hero section in pixels ie "500px" or "800px", otherwise use "auto" and it will fit the content.
  headings: # set a heading
    heading: Design Websites In Minutes
    subHeading: Fast, secure and easy to maintain.
    text: ""
  background: # set a background image
    backgroundImage: "/images/lance-anderson-GOK4iscFSkA-unsplash-2000.jpg" # "/images/my-background-image.jpg" - Path to image
    opacity: 1 # 0 to 1 - Set a lower opacity to blend the background image into the background color, useful if the headings are difficult to read over the top of the image
    monotone: false # true/false - Blends the background image into the background color using preset blend mode filters, looks cool in some cases
    backgroundColorCustom: # "#FFCC00" - Override the background color with your own color code
  image: # set a foreground (thumbnail) image
    image: "" # "/images/my-image.jpg" - Path to image
    shadow: false # true/false - Add a shadow to the image
    border: false # true/false - Add a border to the image
    overlap: false # true/false - Have the image overlap the section below (position absolute), looks cool in some cases
  buttons: # add buttons
  - button: 
    text: Page Builder Documentation # "Read More" - Text on the button
    external: true # true/false - Use when linking to other websites, the button will open in a new window
    url: https://hugo-paradigm.netlify.app/docs/hugo-paradigm/page-builder/using-the-page-builder/ 
    theme: primary-text
- template: info
  options:
    paddingTop: true # true/false
    paddingBottom: true # true/false
    borderTop: false # true/false
    borderBottom: false # true/false
    theme: base # "base", "base-offset", "primary", "primary-offset" - Uses color variables from `data/themes.json` to theme the section
    classes: "" # "my-class my-class-2" - Add custom classes to the section div for custom CSS styling
  align: left # "left", "right" - Aligns the text and image 
  heading: Better Performance
  description: Why wait for pages to build on the fly when you can generate them at
    deploy time? When it comes to minimizing the time to first byte, nothing beats
    pre-built files served over a CDN.
  image: https://source.unsplash.com/qtYhAQnIwSE/800x600y
- template: info
  options:
    paddingTop: true
    paddingBottom: true
    theme: base-offset
  align: right
  heading: Higher Security
  description: With server-side processes abstracted into microservice APIs, surface
    areas for attacks are reduced. You can also leverage the domain expertise of specialist
    third-party services.
  image: https://source.unsplash.com/OfwiURcZwYw/800x600
  buttons:
  - button:
    text: Features # "Read More" - Text on the button
    external: true # true/false - Use when linking to other websites, the button will open in a new window
    url: "/features"
  - button:
    text: Blog # "Read More" - Text on the button
    external: true # true/false - Use when linking to other websites, the button will open in a new window
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
    paddingTop: true # true/false
    paddingBottom: true # true/false
    borderTop: false # true/false
    borderBottom: false # true/false
    theme: base-offset # "base", "base-offset", "primary", "primary-offset" - Uses color variables from `data/themes.json` to theme the section
    classes: "" # "my-class my-class-2" - Add custom classes to the section div for custom CSS styling
  heading: Build Fast, Ship Fast
  contentType: features # "features", "partners", "posts" - The id of another content type. 
  sortBy: weight # "weight", "date" or any front-matter value - Sort the grid
  align: left # "left", "right", "center" - Align the grid
  limit: 4 # 1 to X - Limits the number of cards shown
  columns: 6 # 1 to 12 - Grid is based on 12 columns. For example setting 6 columns would display 2 cards per row
  columnsMobile: 12 # 1 to 12 - Changes the column size for mobile viewport
  card: # set the card style
    partial: "card" # "card", "card-row", "card-image-only" or any file from the `layouts/partials/cards/` folder - Choose the card layout template
    shadow: false # true/false - Add a shadow to the card
    border: false # true/false - Add a border to the card
    padding: true # true/false - Add or remove padding from card
    showThumbnail: true # true/false - Show/hide the thumbnail image
    showFooter: false # true/false - Show/hide the card footer with the "read more"
    showDate: false # true/false - Show/hide the contents publish date
- template: content
  align: left
  columns: 8
- template: cta 
  options:
    paddingTop: true # true/false
    paddingBottom: true # true/false
    borderTop: false # true/false
    borderBottom: false # true/false
    theme: primary # "base", "base-offset", "primary", "primary-offset" - Uses color variables from `data/themes.json` to theme the section
    classes: "" # "my-class my-class-2" - Add custom classes to the section div for custom CSS styling
  heading: Kickstart your Hugo project
  description: Save days and weeks with our best practice templates.
  buttons:
  - button: 
    url: https://www.zerostatic.io/theme/hugo-paradigm/
    text: Buy Theme
    external: true
    theme: primary-offset
---