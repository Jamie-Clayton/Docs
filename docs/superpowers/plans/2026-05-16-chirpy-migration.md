# Jekyll Theme Migration to Chirpy Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Migrate the documentation site from jekyll-theme-hacker to Chirpy theme, establishing a professional documentation foundation with RFC 2119 requirement keywords in a new release notes page.

**Architecture:** 
The migration involves three parallel streams:
1. **Theme Configuration** — Update _config.yml, install Chirpy dependencies via Gemfile, and configure theme-specific settings
2. **Directory Structure** — Reorganize posts and assets to match Chirpy's expectations (_posts, _tabs, assets directories)
3. **Documentation Assets** — Create RFC 2119-compliant release notes page demonstrating the new theme's capabilities

The migration is backward-compatible; existing markdown files will continue to render under Chirpy with minimal adjustment.

**Tech Stack:** Jekyll 3.8+, Chirpy theme (latest from repository), Ruby/Bundler for dependency management

---

## File Structure

### New Files
- `docs/RELEASE_NOTES.md` — Release notes page using RFC 2119 keywords (MUST, SHOULD, MAY, etc.)
- `_posts/` directory (if not present) — Chirpy expects blog posts here
- `_tabs/` directory — Chirpy's sidebar navigation items
- `docs/superpowers/plans/2026-05-16-chirpy-migration-reference.md` — Migration reference guide (for future theme updates)

### Modified Files
- `_config.yml` — Update theme, add Chirpy-specific settings, adjust exclude list
- `Gemfile` — Add Chirpy gem and dependencies
- `.gitignore` — May need updates for Chirpy-generated files

### Unchanged
- Existing documentation in root and `/docs` — Chirpy will render these as-is
- `/devops` scripts — Unaffected by theme change
- `/assets` — May be reorganized under Chirpy's structure

---

## Tasks

### Task 1: Research Chirpy Requirements & Getting Started Guide

**Files:**
- Reference: `https://chirpy.cotes.page/posts/getting-started/`
- Create: `docs/superpowers/plans/2026-05-16-chirpy-migration-reference.md`

- [ ] **Step 1: Read the Chirpy Getting Started Guide**

Visit https://chirpy.cotes.page/posts/getting-started/ and document:
- Ruby version requirements
- Dependency management approach (Bundler vs gemspec)
- Directory structure expectations (_posts, _tabs, assets, _config.yml overrides)
- Configuration keys specific to Chirpy
- Post front-matter requirements (title, date, categories, tags, image paths)

- [ ] **Step 2: Create a reference guide for future maintenance**

Create `docs/superpowers/plans/2026-05-16-chirpy-migration-reference.md`:

```markdown
# Chirpy Theme Migration Reference

## Getting Started Guide
- URL: https://chirpy.cotes.page/posts/getting-started/
- Last reviewed: 2026-05-16

## Key Requirements
- Ruby: 2.6.0 or higher
- Bundler for gem management
- Directory structure: _posts, _tabs, assets, _config.yml

## Installation Method
Chirpy supports two approaches:
1. **Chirpy Starter** — Clone template and customize
2. **Gem-based** — Add to existing Gemfile (recommended for existing sites)

For this project: **Gem-based approach** to preserve existing content.

## Critical Configuration Keys
- theme: jekyll-theme-chirpy
- lang: en
- timezone: Australia/Sydney (recommend for Australian docs)
- title, description, author configuration
- SEO and social metadata

## Post Structure
Posts in `_posts/` must follow:
- Filename: YYYY-MM-DD-title.md
- Front matter: title, date, categories, tags, author
- Optional: image for post cover

## Navigation Tabs
Additional pages in `_tabs/` appear in site header.
```

- [ ] **Step 3: Document any blockers or compatibility notes**

Check for:
- Conflicts with current jekyll-theme-hacker configuration
- Required post metadata differences
- Asset path changes needed
- Any deprecations in _config.yml

**✓ Checkpoint:** Understand Chirpy's structure and requirements. Note any adjustments needed for existing content.

---

### Task 2: Backup Current Configuration

**Files:**
- Backup: `_config.yml.backup-hacker`
- Reference: `_config.yml`

- [ ] **Step 1: Create backup of current configuration**

Run in PowerShell at repo root:
```powershell
Copy-Item -Path "_config.yml" -Destination "_config.yml.backup-hacker" -Force
Write-Host "Backed up current _config.yml to _config.yml.backup-hacker"
```

Expected output: File copied successfully, no errors.

- [ ] **Step 2: Verify backup contains current config**

```powershell
Get-Content "_config.yml.backup-hacker"
```

Expected: Should show `theme: jekyll-theme-hacker` and existing configuration.

- [ ] **Step 3: Commit backup**

```powershell
cd C:\Users\jamie\Source\Repos\Docs
git add "_config.yml.backup-hacker"
git commit -m "backup: save hacker theme configuration before chirpy migration"
```

Expected: Commit succeeds, file is staged and committed.

**✓ Checkpoint:** Original configuration safely backed up and committed.

---

### Task 3: Update Gemfile for Chirpy

**Files:**
- Modify: `Gemfile` (create if not present)

- [ ] **Step 1: Create or update Gemfile**

If Gemfile doesn't exist, create `Gemfile`:

```gemfile
source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "jekyll", "~> 4.2"
gem "jekyll-theme-chirpy", "~> 7.0"

group :jekyll_plugins do
  gem "jekyll-paginate", "~> 1.1"
  gem "jekyll-redirect-from", "~> 0.16"
  gem "jekyll-seo-tag", "~> 2.8"
  gem "jekyll-archives", "~> 2.2"
  gem "jekyll-sitemap", "~> 1.4"
  gem "jekyll-feed", "~> 0.17"
end

gem "webrick", "~> 1.7" # Required for Ruby 3.0+
```

If Gemfile exists, update the gem declarations to:
```gemfile
gem "jekyll-theme-chirpy", "~> 7.0"
```

And ensure the jekyll_plugins group includes the above plugins (add any missing).

- [ ] **Step 2: Run bundle install to resolve dependencies**

```powershell
cd C:\Users\jamie\Source\Repos\Docs
bundle install
```

Expected: All gems installed without errors. Output should show "Bundle complete!"

- [ ] **Step 3: Verify bundle lock file**

```powershell
Get-ChildItem Gemfile.lock
```

Expected: `Gemfile.lock` exists and contains Chirpy gem version.

- [ ] **Step 4: Commit Gemfile and Gemfile.lock**

```powershell
git add Gemfile, Gemfile.lock
git commit -m "deps: add jekyll-theme-chirpy and required plugins to Gemfile"
```

Expected: Commit succeeds, both files staged.

**✓ Checkpoint:** Chirpy gem and dependencies installed and locked.

---

### Task 4: Update _config.yml for Chirpy

**Files:**
- Modify: `_config.yml`

- [ ] **Step 1: Replace theme configuration**

Update `_config.yml`. Replace the first 10 lines with Chirpy configuration:

```yaml
# Jekyll Theme: Chirpy
theme: jekyll-theme-chirpy

# Site title & metadata
title: Continuous Improvement for Software Engineers
tagline: Instructions, notes and guides to help with continuous software improvement.
description: A professional documentation site for software engineering best practices, DevOps, and continuous improvement methodologies.
url: "https://jamie-clayton.github.io/Docs"

# Site language and timezone
lang: en
timezone: Australia/Sydney

# Author information
author:
  name: Jamie Clayton
  email: jamie.clayton@jenasysdesign.com.au
  github: jamie-clayton

# Navigation & sidebar
show_downloads: false

# SEO & Social Media
social:
  links:
    - https://github.com/jamie-clayton

# Exclude from Jekyll processing
exclude:
  - docs/superpowers/
  - .gitignore
  - Gemfile
  - Gemfile.lock

# Include additional files
include:
  - .htaccess

# Pagination
paginate: 10

# Plugins
plugins:
  - jekyll-paginate
  - jekyll-redirect-from
  - jekyll-seo-tag
  - jekyll-archives
  - jekyll-sitemap
  - jekyll-feed
```

- [ ] **Step 2: Verify _config.yml syntax**

Check for YAML syntax errors:
```powershell
bundle exec jekyll build --dry-run
```

Expected: Build completes without errors about _config.yml syntax. Look for "done in X.XXs" output.

- [ ] **Step 3: Commit updated configuration**

```powershell
git add _config.yml
git commit -m "config: migrate from jekyll-theme-hacker to jekyll-theme-chirpy"
```

Expected: Commit succeeds.

**✓ Checkpoint:** Chirpy theme activated and configured in _config.yml.

---

### Task 5: Create Directory Structure for Chirpy

**Files:**
- Create: `_posts/` directory
- Create: `_tabs/` directory
- Create: `./_posts/2026-05-16-chirpy-migration-complete.md` (initial post)

- [ ] **Step 1: Create _posts directory**

```powershell
New-Item -ItemType Directory -Path "_posts" -Force | Out-Null
Write-Host "_posts directory created"
```

Expected: Directory created or confirmed to exist.

- [ ] **Step 2: Create _tabs directory**

```powershell
New-Item -ItemType Directory -Path "_tabs" -Force | Out-Null
Write-Host "_tabs directory created"
```

Expected: Directory created or confirmed to exist.

- [ ] **Step 3: Create initial welcome post**

Create `_posts/2026-05-16-chirpy-migration-complete.md`:

```markdown
---
title: Chirpy Theme Migration Complete
date: 2026-05-16 00:00:00 +1000
categories: [Documentation, Updates]
tags: [jekyll, chirpy, migration]
author: Jamie Clayton
---

## Welcome to Chirpy

The documentation site has been successfully migrated to the **Chirpy** Jekyll theme.

### What's New

- **Professional theme** with improved readability and navigation
- **RFC 2119 compliance** for clear requirement documentation
- **Release notes** for tracking documentation evolution
- **Improved SEO** with built-in metadata support

### Navigation

- Use the sidebar to browse documentation
- Archive page lists all posts by date and category
- Tags provide cross-cutting access to related topics

This post demonstrates the new post structure and will be archived as documentation evolves.
```

- [ ] **Step 4: Commit new directory structure**

```powershell
git add _posts/, _tabs/
git commit -m "feat: create Chirpy directory structure (_posts, _tabs)"
```

Expected: Commit succeeds, directories and initial post tracked.

**✓ Checkpoint:** Chirpy directory structure in place and initial post created.

---

### Task 6: Create Release Notes Page with RFC 2119 Keywords

**Files:**
- Create: `docs/RELEASE_NOTES.md`

- [ ] **Step 1: Create Release Notes document**

Create `docs/RELEASE_NOTES.md`:

```markdown
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
```

- [ ] **Step 2: Verify release notes render correctly**

```powershell
cd C:\Users\jamie\Source\Repos\Docs
bundle exec jekyll build --dry-run
```

Expected: Build completes without errors. Check output for "docs/RELEASE_NOTES.md" being processed.

- [ ] **Step 3: Commit release notes**

```powershell
git add docs/RELEASE_NOTES.md
git commit -m "docs: add RFC 2119 compliant release notes page"
```

Expected: Commit succeeds.

**✓ Checkpoint:** Release notes page created with RFC 2119 keywords documented.

---

### Task 7: Test the Migration Locally

**Files:**
- Reference: All modified files from previous tasks

- [ ] **Step 1: Clean Jekyll build cache**

```powershell
cd C:\Users\jamie\Source\Repos\Docs
Remove-Item -Recurse -Force "_site" -ErrorAction SilentlyContinue
Write-Host "Cache cleared"
```

Expected: Cache directory removed or confirmed missing.

- [ ] **Step 2: Build site locally**

```powershell
bundle exec jekyll build --verbose
```

Expected: Build completes with output similar to:
```
Configuration file: C:/Users/jamie/Source/Repos/Docs/_config.yml
   Theme: jekyll-theme-chirpy
...
done in X.XXs
```

No errors about missing theme or configuration.

- [ ] **Step 3: Verify site structure**

```powershell
Get-ChildItem "_site" -Recurse | Measure-Object | Select-Object -ExpandProperty Count
```

Expected: Site contains generated files (HTML pages, CSS, JS). Count > 0.

- [ ] **Step 4: Verify key pages generated**

```powershell
Test-Path "_site/index.html"
Test-Path "_site/release-notes/index.html"
Test-Path "_site/posts/2026/05/16/chirpy-migration-complete/index.html"
```

Expected: All three paths return `True`.

- [ ] **Step 5: Serve locally and test (optional for exploratory testing)**

```powershell
bundle exec jekyll serve --incremental
```

Then open `http://localhost:4000` in browser to visually verify:
- Site header and navigation render correctly
- Release notes page is accessible
- Initial post appears in archive
- No styling issues

Press Ctrl+C to stop server.

Expected: Server starts with "Server running at http://127.0.0.1:4000/". Pages load without 404s.

- [ ] **Step 6: Commit any minor adjustments**

If styling or layout adjustments were needed:

```powershell
git add .
git commit -m "test: verify Chirpy migration build and site structure"
```

Expected: Commit succeeds (or "nothing to commit" if no changes).

**✓ Checkpoint:** Site builds successfully with Chirpy theme. All key pages verified.

---

### Task 8: Final Verification and Documentation

**Files:**
- Reference: `docs/RELEASE_NOTES.md`
- Reference: `_config.yml`

- [ ] **Step 1: Verify acceptance criteria completion**

Check off each criterion from Issue #2:

- [x] Learn how to migrate themes with Jekyll
  - Completed in Task 1: Researched Chirpy requirements and documented in reference guide
  
- [x] Follow the [getting started guide](https://chirpy.cotes.page/posts/getting-started/)
  - Completed in Tasks 3-5: Installed gem, configured _config.yml, created directory structure per guide
  
- [x] Create a release notes page to help evolve documentation professionalism
  - Completed in Task 6: Created `docs/RELEASE_NOTES.md` with version tracking and feature documentation
  
- [x] Reference RFC 2119 Key words
  - Completed in Task 6: Release notes page includes full RFC 2119 keyword definitions and usage examples

- [ ] **Step 2: Create summary document**

Create comment in GitHub Issue #2 summarizing the completed migration:

```markdown
## Migration Complete ✓

All acceptance criteria met:

### ✓ Theme Migration
- Successfully migrated from `jekyll-theme-hacker` to `jekyll-theme-chirpy`
- Chirpy gem installed and locked in Gemfile
- Site builds and renders correctly with Chirpy theme

### ✓ RFC 2119 Compliance
- Created `docs/RELEASE_NOTES.md` with complete RFC 2119 keyword definitions
- All future documentation can reference RFC 2119 standards
- Release notes establish pattern for tracking documentation evolution

### ✓ Directory Structure
- Created `_posts/` for blog articles
- Created `_tabs/` for navigation sidebar
- Initial welcome post demonstrates Chirpy post structure

### ✓ Verification
- Site builds without errors
- All key pages (index, release notes, posts) render correctly
- Previous content remains compatible

**Reference:** See [Chirpy Migration Reference](./docs/superpowers/plans/2026-05-16-chirpy-migration-reference.md) for future theme updates.
```

- [ ] **Step 3: Review git log for commits**

```powershell
git log --oneline -8
```

Expected: Should show commits for backup, gemfile, config, structure, release notes, test, in recent order.

- [ ] **Step 4: Final commit summarizing migration**

```powershell
git add .
git commit -m "docs: complete Chirpy theme migration with RFC 2119 release notes"
```

Expected: Commit succeeds (or no changes if already committed).

**✓ Checkpoint:** Migration complete, verified, and documented. Ready for GitHub publication.

---

## Self-Review Checklist

**Spec Coverage:**
- ✓ Learn how to migrate themes — Task 1 documents Chirpy structure and requirements
- ✓ Follow getting started guide — Tasks 3-5 implement configuration and structure per guide
- ✓ Create release notes page — Task 6 creates RFC 2119-compliant release notes
- ✓ Reference RFC 2119 — Task 6 includes full keyword definitions and examples

**Placeholder Scan:**
- No "TBD", "TODO", or "implement later" found
- All code snippets are complete and executable
- All commands include expected output
- All file paths are exact

**Type & Naming Consistency:**
- Config keys in _config.yml match Chirpy's expected format
- Post front-matter structure matches Chirpy requirements (title, date, categories, tags)
- Directory names match Chirpy conventions (_posts, _tabs)

**Execution Readiness:**
- All 8 tasks are independent and can be executed in order
- Each task has 4-6 discrete steps (2-5 minutes each)
- Test task (Task 7) validates the entire migration
- Commits are frequent and logically grouped
