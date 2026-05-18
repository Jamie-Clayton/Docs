# Continuous Improvement for Software Engineers

> Practical documentation for software engineers — built from real-world experience, improved continuously.

**Read it on the web:** **[jamie-clayton.github.io/Docs](https://jamie-clayton.github.io/Docs/)**

The site is built with [Jekyll](https://jekyllrb.com/) and the [Chirpy](https://github.com/cotes2020/jekyll-theme-chirpy) theme, and deployed automatically to GitHub Pages on every push to `master`.

## Browse the Content

The site uses the [Diátaxis framework](https://diataxis.fr/) — content is organised by purpose, not topic:

| Diátaxis Type | What it's for | Browse on the site |
|---------------|---------------|---------------------|
| **Tutorial** | Learning by doing — pick this if you're new to a tool | [Categories → Tutorial](https://jamie-clayton.github.io/Docs/categories/tutorial/) |
| **How-to** | Task-oriented recipes — pick this when you know what you want to achieve | [Categories → How-to](https://jamie-clayton.github.io/Docs/categories/how-to/) |
| **Reference** | Command and option lookup — pick this when you need a specific flag | [Categories → Reference](https://jamie-clayton.github.io/Docs/categories/reference/) |
| **Explanation** | Conceptual reading — pick this when you want to understand *why* | [Categories → Explanation](https://jamie-clayton.github.io/Docs/categories/explanation/) |

Or browse by topic: **[Tags](https://jamie-clayton.github.io/Docs/tags/)** · **[Archives](https://jamie-clayton.github.io/Docs/archives/)** · **[About](https://jamie-clayton.github.io/Docs/about/)**

## Authoring

Posts live under [`_posts/`](_posts/) and follow Chirpy's filename convention `YYYY-MM-DD-slug.md` with a small block of YAML frontmatter:

```yaml
---
title: Your Post Title
date: 2026-05-18 09:00:00 +1000
categories: [Tutorial, DevOps]   # [Diátaxis type, topic group]
tags: [powershell, windows]      # specific topics
author: Jamie Clayton
---
```

Static sidebar pages (HOME, CATEGORIES, TAGS, ARCHIVES, ABOUT) live under [`_tabs/`](_tabs/).

For local preview:

```pwsh
bundle install
bundle exec jekyll serve
```

## Contributing

See [Contributing.md](Contributing.md) for the code of conduct and pull request process.

## License

Content is licensed under the [Creative Commons License](./LICENSE).

[![contributors](https://contributors-img.web.app/image?repo=Jamie-Clayton/Docs)](https://github.com/Jamie-Clayton/Docs/graphs/contributors)
