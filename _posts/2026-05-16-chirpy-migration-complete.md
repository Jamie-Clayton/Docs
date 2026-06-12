---
title: Chirpy Theme Migration Complete
date: 2026-05-16 00:00:00 +1000
categories: [Documentation, Updates]
tags: [jekyll, chirpy, migration]
author: Jamie Clayton
---

## We moved the docs to Chirpy

The documentation site now runs on the **Chirpy** Jekyll theme. Here's what changed and why I picked it.

The old setup was fine for a handful of pages but got awkward to read and navigate as the content grew. Chirpy buys us a cleaner reading experience and proper navigation out of the box, which is most of the reason I switched. The rest:

- **RFC 2119 compliance** for clear requirement documentation — when a doc says MUST or SHOULD, it now means the standard thing
- **Release notes** so changes to the docs are tracked rather than silent
- **Built-in SEO metadata**, so I'm not hand-rolling tags

### Finding your way around

- The sidebar is the main way to browse
- The Archive page lists every post by date and category
- Tags cut across the structure when you're chasing a topic rather than a section

This post doubles as a smoke test for the new post structure. It'll get archived as the docs grow.
