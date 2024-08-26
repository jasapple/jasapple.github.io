---
title: Pihole Prometheus 
last_modified_at: 2024-08-25-T19:00:00-07:00
---

# Pihole and Prometheus

Pihole is a great DNS sinkhole to block ads on a local network. It's web interface has great dashboards but exposes this data in a plain text key value format. I utilize prometheus and graphite for metric logging and visualize the data in grafana, all hosted in [kubernetes](/kubernetes), and I wanted to ingest pihole's metrics into this ecosystem.

In my research, I found a [pihole exporter](https://github.com/eko/pihole-exporter){:target="_blank"} which is referenced a fair amount by other guides and has great community reception. I however did not want to use a middleware service and would prefer a service (pihole) expose metrics directly. I decided to built a metrics endpoint directly into pihole's web interface that can be directly scraped by prometheus.

## Overview of changes.

For basic functionality, I added a new `metrics.php` file in the pihole's lighttdp directory (`/var/www/html/admin`). The php file calls the api FTLAPI('stats'), which returns an array of metrics, and formats the output to Prometheus's [exposition format](https://prometheus.io/docs/instrumenting/exposition_formats/){:target="_blank"}. This alone was sufficient for prometheus to scrape the pihole directly but I wanted to be able to toggle the metric's page from the UI. I added a section in the `settings.php` file and a corresponding function in `scripts/pi-hole/php/savesettings.php` which toggled a `setupvar`. I lastly added a function in pihole's `/opt/pihole/webpage.sh` script to manage a new Key Value variable `METRIC_PAGE_ENABLE`.

## Proposing upstream changes

I wanted to propose these changes to the upstream pihole project but while reviewing feature requests in the pihole discourse I found [this](https://discourse.pi-hole.net/t/preparing-for-the-v6-release/71809){:target="_blank"} announcement for the v6 release. The main developers are moving away from lighttdp and have the pihole-FTL binary handle the web processing. As the main developers are focused on releasing v6, I have decided to wait for the release before reimplementing this for use in the pihole-FTL binary. For those who want to utilize this themselves, I have released my changes [here](https://github.com/jasapple/pihole-prom){:target="_blank"} with installation instructions for pihole v5.