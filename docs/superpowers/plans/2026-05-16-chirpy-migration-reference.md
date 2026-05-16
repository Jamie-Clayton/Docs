# Chirpy Jekyll Theme Migration Reference Guide

**Last Reviewed:** 2026-05-16  
**Source Documentation:** https://chirpy.cotes.page/posts/getting-started/  
**GitHub Repository:** https://github.com/cotes2020/jekyll-theme-chirpy

---

## Overview

This reference guide documents the Jekyll Theme Chirpy requirements and specifications for migrating from `jekyll-theme-hacker`. It serves as a technical resource for future migrations and version upgrades.

---

## 1. Ruby & Dependency Management

### Ruby Version
- **Current Requirement:** Not explicitly documented in official guides
- **Recommended:** Ruby 3.0+ (typical Jekyll requirement)
- **Note:** Check the `jekyll-theme-chirpy.gemspec` file in the repository for exact version constraints

### Dependency Management: Bundler (Required)
- **Approach:** Gem-based via Bundler (recommended over forking)
- **Why:** Simplifies upgrades, easier maintenance, less customization overhead
- **File:** `Gemfile` and `Gemfile.lock` required
- **Cross-Platform Note:** For GitHub Actions deployment on Linux, run:
  ```bash
  bundle lock --add-platform x86_64-linux
  ```

### Installation Method
Chirpy supports two installation approaches:

| Approach | Use Case | Upgrade Path | Customization |
|----------|----------|--------------|--------------|
| **Starter Template** (Recommended) | Content focus, minimal config | Easy | Limited |
| **Fork** | Extensive customization | Complex | Extensive |

**Recommendation for this migration:** Use starter template approach (gem-based) for simplified maintenance.

---

## 2. Directory Structure

### Expected Directories
```
project-root/
├── _posts/              # Blog post files (YYYY-MM-DD-TITLE.md format)
├── _data/
│   ├── contact.yml      # Social contact options (sidebar)
│   └── authors.yml      # Author information (post attribution)
├── _tabs/               # Navigation tabs (about, archives, categories, tags)
├── assets/
│   ├── css/             # CSS files (built via `npm run build` if forking)
│   └── img/
│       └── favicons/    # Favicon files (see Favicon Customization)
├── _config.yml          # Main Jekyll configuration
├── Gemfile              # Ruby dependencies
└── Gemfile.lock         # Locked dependency versions
```

### _posts/ Directory
- **Naming Convention:** `YYYY-MM-DD-TITLE.EXTENSION`
- **Extensions Supported:** `.md` or `.markdown`
- **Example:** `2026-05-16-getting-started.md`

### _tabs/ Directory (Optional)
- Optional directory for navigation tabs
- Tabs appear in header navigation (HOME, CATEGORIES, TAGS, ARCHIVES, ABOUT)
- Each tab file defines custom navigation entries

---

## 3. Critical Configuration Keys for Chirpy

### Essential _config.yml Settings
```yaml
# Site metadata
title: Site Title
description: Site Description
url: "https://yourdomain.com"           # Your site's full domain
baseurl: "/project-name"                # Required if deployed as project site (omit for user site)

# Chirpy-specific
avatar: "path/to/avatar.png"            # Sidebar avatar image
timezone: "Australia/Sydney"            # Your timezone
lang: "en"                              # Language (en, zh-CN, etc.)

# Optional but common
paginate: 10                            # Posts per page
theme: jekyll-theme-chirpy              # Theme specification
```

### Theme-Specific Variables
- **avatar:** Path to profile image in sidebar (recommended: 200×200px PNG/JPG, location: `assets/img/` or leave blank to use GitHub profile picture)
- **timezone:** Affects post date display (use valid IANA timezone names)
- **lang:** Language code for UI text (default: `en`)

### Social Contacts
- **File:** `_data/contact.yml`
- **Purpose:** Define social media links shown in sidebar footer
- **Format:** YAML key-value pairs (e.g., GitHub, Twitter, LinkedIn)

### Author Information
- **File:** `_data/authors.yml`
- **Purpose:** Centralized author metadata referenced in post front-matter
- **Usage:** Post authors reference entries in this file

---

## 4. Post Front-Matter Requirements

### Required Fields
```yaml
---
title: Post Title
date: YYYY-MM-DD HH:MM:SS +/-TTTT    # Example: 2026-05-16 14:30:00 +1000
categories: [Category1, Category2]    # Up to 2 elements
tags: [tag1, tag2, tag3, ...]         # Zero or more tags
---
```

### Optional Fields
```yaml
---
layout: post                           # Defaults to 'post' (omit if using default)
author: author_name                    # References entry in _data/authors.yml
description: Custom summary            # If omitted, uses post opening content
toc: false                            # Disable table of contents (default: true)
comments: false                        # Disable comment section (default: true)
media_subpath: /path/to/media/        # URL prefix for media resources
pin: true                             # Pin post to homepage (default: false)
math: true                            # Enable MathJax equations (default: false)
mermaid: true                         # Enable diagram generation (default: false)

# Featured image
image:
  path: /path/to/image.jpg
  alt: Image description text
  lqip: /path/to/lqip-placeholder.jpg  # Low-quality image placeholder
---
```

### Front-Matter Constraints
- **Categories:** Maximum 2 elements
- **Tags:** Unlimited elements
- **Date Format:** ISO 8601 with timezone offset (e.g., `2026-05-16 14:30:00 +1000`). Use IANA offsets: UTC=+0000, EST=-0500, PST=-0800, AEST=+1000, etc.
- **Image Dimensions:** Recommended 1200×630px for featured images

### Post Filename Format
```
_posts/YYYY-MM-DD-title-slug.md
```
- Date must match the date in front-matter
- Title slug should use hyphens (no spaces)
- File extension must be `.md` or `.markdown`

---

## 5. Asset Path Changes & Image Handling

### Featured Image References
```markdown
---
image:
  path: /assets/img/featured.jpg     # Path relative to site root
  alt: "Description for accessibility"
---
```

### Inline Image Markdown
```markdown
![Image description](/assets/img/image.jpg)
{: w="700" h="400" }                  # Optional: specify dimensions
*Image caption in italics below*
```

### Media Subpath Option
```yaml
# Set in post front-matter to avoid repeating path prefixes
media_subpath: /assets/img/blog/
```
Then reference images as: `![Description](image.jpg)` (path prepended automatically)

### Image Syntax Recommendation

**Option A: Using media_subpath (Recommended)**
If you set `media_subpath: /assets/img` in front-matter or _config.yml, use simple paths:
```markdown
![Alt text](image.jpg)
```

**Option B: Absolute Paths (Alternative)**
Use full paths like `/assets/img/image.jpg` for individual images:
```markdown
![Alt text](/assets/img/image.jpg)
{: w="700" h="400" }
```

**For this migration, use Option A** (media_subpath) to minimize repetition and match Chirpy best practices.

---

## 6. Navigation & Tabs System

### Built-in Navigation Tabs
Chirpy automatically displays:
- **HOME** - Homepage with paginated posts
- **CATEGORIES** - Category archive page
- **TAGS** - Tag archive page
- **ARCHIVES** - Timeline view of all posts
- **ABOUT** - About page (from `_tabs/about.md`)

### Custom Tabs
To add custom navigation tabs:
1. Create files in `_tabs/` directory
2. Use front-matter: `title`, `icon`, and `order` (for sorting)
3. File example: `_tabs/projects.md`

```yaml
---
title: Projects
icon: fas fa-code
order: 5
---

Content here...
```

---

## 7. Breaking Changes & Compatibility Notes

### Migration from jekyll-theme-hacker
| Item | Hacker | Chirpy | Notes |
|------|--------|--------|-------|
| **Theme Type** | Gem-based | Gem-based | Compatible approach |
| **Config Key** | `theme: jekyll-theme-hacker` | `theme: jekyll-theme-chirpy` | Update _config.yml |
| **Directory Structure** | Minimal | Requires _posts/ _data/ | Create new directories |
| **Post Format** | Flexible | Strict front-matter | Add required YAML fields |
| **Assets** | Root assets/ | assets/img/, assets/css/ | Restructure asset paths |
| **Navigation** | Custom | Built-in tabs | Different menu system |
| **Author Support** | Basic | _data/authors.yml | New author management |

### Known Incompatibilities
1. **Jekyll Settings:**
   - `show_downloads: false` (hacker-specific) should be removed
   - No direct equivalent in Chirpy config

2. **Markdown Files:**
   - Chirpy requires stricter front-matter compliance
   - Posts missing required fields (title, date, categories) will not render
   - Date format must include timezone offset

3. **Layout Structure:**
   - Custom layouts from Hacker theme will not work
   - Must use Chirpy's built-in layouts (post, page, home, etc.)

4. **Asset Organization:**
   - Images must be in `assets/img/` subdirectories
   - CSS build pipeline differs (uses npm if forking)

### Major Version Upgrade Notes
- **v5.6.0+:** JS distribution files removed; compilation via `npm run build` required (fork only)
- **v7.0.0+:** Bootstrap CSS significantly refactored
- **Recommendation:** Always review release notes when upgrading major versions

---

## 8. Installation & Setup Process (Overview)

### Step 1: Dependency Setup
```bash
bundle install
bundle lock --add-platform x86_64-linux  # For GitHub Actions
```

### Step 2: Configuration
- Update `_config.yml` with Chirpy keys (url, baseurl, avatar, timezone, lang)
- Create/update `_data/contact.yml` for social links
- Create/update `_data/authors.yml` if using multiple authors

### Step 3: Directory Structure
- Ensure `_posts/`, `_tabs/`, `assets/img/favicons/` directories exist
- Migrate existing posts to `_posts/` with proper naming convention
- Update post front-matter to match Chirpy requirements

### Step 4: Local Testing
```bash
bundle exec jekyll serve
# Access at http://127.0.0.1:4000
```

### Step 5: Production Build
```bash
JEKYLL_ENV=production bundle exec jekyll build
```

---

## 9. Deployment Considerations

### GitHub Pages
- Chirpy works with GitHub Actions workflow
- Ensure `bundle lock --add-platform x86_64-linux` is run on non-Linux systems
- Workflows should use: `JEKYLL_ENV=production bundle exec jekyll build`

### Linux Requirement
- Starter template and gem approach work on all platforms
- Fork approach benefits from Linux for development consistency

---

## 10. Deprecations from jekyll-theme-hacker

### Hacker-Specific Config Keys to Remove
- `show_downloads: false` (no equivalent in Chirpy)
- Any custom `hacker_*` prefixed keys

### File Structure Changes
- Move content from root `.md` files into `_posts/` with proper front-matter
- Reorganize assets into `assets/img/` subdirectory structure
- Remove any custom Jekyll theme overrides specific to Hacker

---

## 11. Reference Links

| Resource | URL |
|----------|-----|
| Getting Started Guide | https://chirpy.cotes.page/posts/getting-started/ |
| Writing Posts Guide | https://chirpy.cotes.page/posts/write-a-new-post/ |
| GitHub Repository | https://github.com/cotes2020/jekyll-theme-chirpy |
| GitHub Wiki | https://github.com/cotes2020/jekyll-theme-chirpy/wiki |
| Upgrade Guide | https://github.com/cotes2020/jekyll-theme-chirpy/wiki/Upgrade-Guide |

---

## 12. Quick Reference: Hacker → Chirpy Migration Checklist

### 1. Don't Replace Wholesale
The current `_config.yml` (backed up in Task 2) contains valuable metadata. Merge the new Chirpy config with the existing file instead of replacing it entirely.

### 2. Preserve These Keys from Current Config
- `title`, `description`, `author`, `email`, `github_username`, `twitter_username`
- `url` (your site domain)
- `exclude` array (superpowers exclusion)
- Any custom collections, plugins, or Jekyll-specific settings

### Current jekyll-theme-hacker Config
```yaml
theme: jekyll-theme-hacker
title: Continuous Improvement for Software Engineers
description: Instructions, notes and guides to help with continuous software improvement.
show_downloads: false
exclude:
  - docs/superpowers/
```

### 3. Add/Update These Chirpy-Specific Keys
```yaml
theme: jekyll-theme-chirpy
lang: en
timezone: Australia/Sydney
avatar: "assets/img/avatar.png"       # or omit to use GitHub profile picture
baseurl: ""                           # Empty for user site; "/repo-name" for project site
paginate: 10

# Author block (required)
author:
  name: Your Name
  email: your.email@example.com
  github: github_username
```

### 4. Remove These Deprecated Keys
- `show_downloads: false` (hacker-specific, not supported)
- Any `hacker_*` prefixed keys

### 5. Create Supporting Files
- `_data/contact.yml` (social media links)
- `_data/authors.yml` (author information)

---

## Notes for Future Migrations

- **Ruby Version:** Check `jekyll-theme-chirpy.gemspec` for current requirements
- **Breaking Changes:** Always review GitHub releases before upgrading
- **Community:** Refer to GitHub Issues for common problems
- **Customization:** If needing heavy customization, consider fork approach but expect upgrade complexity
- **Testing:** Always test locally with `bundle exec jekyll serve` before pushing

