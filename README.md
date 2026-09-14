Author: Joshua Singh (hi@jasapple.com)

Purpose: About me website to display resume, a bit about me, and any project blog posts.

Created using the [Minimual Mistakes](https://mademistakes.com/work/jekyll-themes/minimal-mistakes/) Jeykl Theme and hosted on Github Pages.


## Build/dev

You can use the `build.sh` and the `serve.sh`, focused on using macOS's container runtime. Manual options below.

### docker
`docker build -t github-pages`

`docker run --rm -p 4000:4000 -v "$(pwd):/site" github-pages`


### macOS container
`container system start`

`container build -g github=pages`

`container run --rm -p 4000:4000 -v "$(pwd):/site" github-pages`