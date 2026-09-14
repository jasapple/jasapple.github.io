---
title: "Containerizing This Site"
last_modified_at: 2026-09-13-T14:00:00-07:00
---

# Making this site's development portable

This site uses Github Pages for free hosting. Under the hood, it runs Jekyll to generate the pages and uses the theme '[Minimual Mistakes](https://mademistakes.com/work/jekyll-themes/minimal-mistakes/){:target="_blank"}'. To preview the site, I needed to install the correct version of ruby, install the theme's needed Gems, and configure the server's to use the local configurations. This was a clear usecase for containerization.

I originally had this setup working on my older Macbook Pro, but after an update the needed dependencies broke. Since that laptop was much older, I never opted to fix the configuration and have since moved to a new mac system for current development work. Instead of installing and managing ruby versions, containerazation seemed the best fit. Instead of using Docker, I choise to use macOS's build in [container](https://github.com/apple/container){:target="_blank"} tool. I built the initial DockerFile and had some success, but updates to site pages did not update/rebuild automatically. Working alongside ChatGPT, adding the `--force_polling` ensured the site's volume was kept up-to-date and I was able to quickly write new pages.