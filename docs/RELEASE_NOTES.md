---
layout: page
title: Release Notes
permalink: /release-notes/
---

# Release Notes

This document tracks significant updates to the documentation site using terminology defined in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119).

## RFC 2119 Keywords

The keywords "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in RFC 2119:

- **MUST / REQUIRED / SHALL**: Absolute requirement; implementation is mandatory.
- **MUST NOT / SHALL NOT**: Absolute prohibition; implementation is forbidden.
- **SHOULD / RECOMMENDED**: Strong recommendation; avoid without good reason.
- **SHOULD NOT**: Strong discouragement; avoid unless justified.
- **MAY / OPTIONAL**: Implementation is truly optional; choose at discretion.

---

## Version 2.0.0 — Chirpy Theme Migration (2026-05-16)

### New Features

- **Chirpy Theme** — Professional Jekyll theme with enhanced readability, SEO, and navigation
  - MUST be used for all new documentation going forward
  - SHOULD conform to Chirpy's post structure (YYYY-MM-DD-title.md format)
  - MAY include featured images for improved post previews

- **RFC 2119 Compliance** — All requirement documentation now uses standardized keywords
  - MUST interpret RFC 2119 keywords as defined above
  - RECOMMENDED for all policy and standard documentation

- **Release Notes Page** — This page tracks evolution of documentation standards
  - SHOULD be updated with each significant change
  - MUST include version numbers and dates

### Deprecations

- `jekyll-theme-hacker` — Previous theme, no longer maintained for this project
  - SHOULD NOT be referenced in new documentation
  - MAY remain visible in git history for reference

### Breaking Changes

None. Existing markdown files remain compatible with Chirpy.

### Known Issues

- Archive page generation requires Jekyll rebuild (run `bundle exec jekyll build`)
- Category pages MAY take additional time to generate on first build

### Upgrade Path

For documentation maintainers:

1. **MUST** ensure all new posts are in `_posts/` directory
2. **SHOULD** follow Chirpy front-matter conventions (title, date, categories, tags)
3. **MAY** migrate existing documentation by moving files and updating metadata

---

## Version 1.0.0 — Initial Documentation Site (2024-05-12)

Initial publication of documentation site with jekyll-theme-hacker.

---

## Maintenance Roadmap

- Q3 2026: Review Chirpy theme updates and compatibility
- Q4 2026: Consider SEO enhancements and structured data
- 2027: Evaluate documentation search and cross-referencing improvements
