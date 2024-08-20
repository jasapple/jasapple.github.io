---
title: Simple Menu
last_modified_at: 2024-07-09-T15:00:00-07:00
---

# Simple Menu

[Github Source](https://github.com/jasapple/simple-menu){:target="_blank"}

## Background
For a convenience store, being able to add and modify menu items as customer needs change is a powerful tool. Often, small delis do not need, or can afford, a digital signage solution offered by most digital signage providers, OOS or commercial. This application offers a basic webpage to showcase different sections of items and to be able to adjust their prices via a simple web form.

## Who is this for

My primary target is convenience stores with a deli or hot food area. I wanted to keep this simple as most store owners/operators do not have access to the skills to setup a digital signage system with rich/dynamic graphics for their signage. Likewise, when updating an item, you will often see the item or price 'taped over' which often, in my opinion, looks unprofessional. Tis allows for an operator to quickly load the admin page and update a price or completely strikethrough an item when it is temporarily unavailable.

## Development

I took a python course to enhance my python programming skills where we utilized flask for the web development module. I used this as a base for this new project. I started with a basic webpage which loaded information from a CSV file. I needed a more robost data structure which prompted me to switch to using sqlite3 for data storage.


## TODO

- Dockerize
- Linux install file
- Windows Install 