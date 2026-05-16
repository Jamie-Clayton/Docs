# Chirpy UX Refinement Design Specification

**Date:** 2026-05-17  
**Scope:** Visual styling, navigation, and sidebar improvements to match Chirpy professional standards  
**Status:** Design approved, ready for implementation

---

## Executive Summary

The documentation site is currently configured with Chirpy theme but is not fully utilizing its professional features. The current light-theme-only setup with minimal left sidebar navigation lacks the visual polish and discoverability of a complete Chirpy implementation.

**Goal:** Enable Chirpy's full feature set (dark/light theme toggle, complete sidebar navigation, GitHub avatar, social links) to match the professional appearance shown at https://chirpy.cotes.page/, while maintaining the existing content structure.

**Approach:** Use Chirpy's built-in features via configuration only—no custom code or styling required.

---

## Design Scope

### In Scope
- **Dark/Light Theme Toggle:** Enable Chirpy's built-in theme mode switching
- **Sidebar Navigation:** Display full navigation (HOME, CATEGORIES, TAGS, ARCHIVES, ABOUT)
- **Avatar/Branding:** Display GitHub profile avatar in sidebar
- **Social Links:** Add social contact links (GitHub, email) in sidebar footer
- **About Page:** Create About tab for navigation
- **Theme Persistence:** Store user's theme preference in browser

### Out of Scope
- Custom CSS or styling (use Chirpy defaults)
- Content restructuring or migration
- Custom JavaScript or theme overrides
- New features beyond Chirpy's built-in capabilities

---

## Architecture

### Configuration-Driven Approach

All changes are configuration files (YAML) that tell Chirpy which features to enable. Chirpy handles rendering, styling, and interactivity automatically.

```
User visits site
    ↓
Chirpy theme reads _config.yml → avatar, theme_mode, author
Chirpy reads _data/contact.yml → social links
Chirpy reads _tabs/ directory → navigation tabs
Chirpy reads _posts/ front-matter → categories, tags, dates
    ↓
Renders sidebar with avatar, nav, social links
Renders theme toggle button
    ↓
User can toggle dark ↔ light mode (browser remembers choice)
```

### File Changes Required

| File | Action | Purpose |
|------|--------|---------|
| `_config.yml` | Modify | Add `avatar:` (leave blank), `theme_mode: auto` |
| `_data/contact.yml` | Create | Define social media links (GitHub, email) |
| `_tabs/about.md` | Create | About page content + metadata |
| `_posts/` (existing) | Verify | Ensure front-matter has categories and tags |

---

## Configuration Details

### _config.yml Changes

**Current state:** Partially configured for Chirpy.

**Required additions:**

```yaml
# Avatar configuration (leave blank to use GitHub profile picture)
avatar: ""

# Theme mode: auto (detect system preference), light, or dark
theme_mode: auto

# Ensure these are set (likely already present)
author:
  name: Jamie Clayton
  email: jamie.clayton@jenasysdesign.com.au
  github: jamie-clayton

title: Continuous Improvement for Software Engineers
tagline: Instructions, notes and guides to help with continuous software improvement.
description: A professional documentation site for software engineering best practices, DevOps, and continuous improvement methodologies.
url: "https://jamie-clayton.github.io/Docs"
lang: en
timezone: Australia/Sydney
```

**Notes:**
- `avatar: ""` (leave blank) tells Chirpy to fetch your GitHub profile picture automatically
- `theme_mode: auto` detects user's system preference and provides a toggle button
- Other settings should already be present from migration

### _data/contact.yml (New File)

Creates social media links displayed in sidebar footer.

```yaml
- type: github
  icon: "fab fa-github"
  url: "https://github.com/jamie-clayton"

- type: email
  icon: "fas fa-envelope"
  url: "mailto:jamie.clayton@jenasysdesign.com.au"
```

**Notes:**
- `type:` is the identifier (used for icon mapping)
- `icon:` uses Font Awesome classes (fab = brand, fas = solid)
- `url:` can be any link (GitHub, Twitter, LinkedIn, email, etc.)
- Chirpy auto-renders icons in sidebar footer

---

## Components

### Dark/Light Theme Toggle

**Feature:** Built-in button in header (moon/sun icon).

**User flow:**
1. User clicks toggle button (top-right corner of header)
2. Site switches between dark and light mode
3. Browser saves preference (localStorage)
4. Preference persists across sessions

**What changes visually:**
- **Light mode:** Bright background, dark text (current appearance)
- **Dark mode:** Dark sidebar and backgrounds, light text (Image #2 reference)
- Colors, contrast, and typography remain consistent per Chirpy design

**Implementation:** No code required. Chirpy provides the toggle UI and CSS. Setting `theme_mode: auto` in _config.yml enables it.

### Sidebar Navigation Structure

**Auto-generated tabs:**

| Tab | Source | Content |
|-----|--------|---------|
| HOME | Built-in | Paginated list of posts |
| CATEGORIES | Auto-generated | Posts organized by category (from post front-matter) |
| TAGS | Auto-generated | Posts organized by tags (from post front-matter) |
| ARCHIVES | Auto-generated | Posts organized by date (from post front-matter) |
| ABOUT | `_tabs/about.md` | Custom about page |

**Sidebar elements (top to bottom):**
1. **Avatar:** GitHub profile picture (fetched automatically)
2. **Site title:** "Continuous Improvement for Software Engineers"
3. **Tagline:** "Instructions, notes and guides..."
4. **Navigation icons:** 🏠 📁 🏷️ 📅 ℹ️ (linked to tabs above)
5. **Social icons:** GitHub, email (from `_data/contact.yml`)

**Implementation:** No code required. Chirpy renders sidebar from config and directory structure.

### About Page (_tabs/about.md)

**Purpose:** Provides content for the ABOUT navigation tab.

**File structure:**

```yaml
---
title: About
icon: fas fa-info-circle
order: 5
---

# About This Documentation Site

[Your about page content here...]
```

**Notes:**
- `title:` appears in navigation and page header
- `icon:` displays next to nav item (Font Awesome class)
- `order:` controls tab position (5 = after ARCHIVES)
- Content can be markdown (links, lists, formatting)

---

## Data Flow & Dependencies

### Post Front-Matter Requirements

For CATEGORIES, TAGS, and ARCHIVES to auto-generate properly, existing posts must have:

```yaml
---
title: Post Title
date: YYYY-MM-DD HH:MM:SS +TTTT
categories: [Category1, Category2]  # Max 2 elements
tags: [tag1, tag2, tag3, ...]       # Unlimited
---
```

**Verification task:** Spot-check existing posts in `_posts/` to ensure all have categories and tags. Posts missing these fields won't appear in category/tag/archive views.

### Chirpy's Auto-Generation

Once `_posts/` files have complete front-matter, Chirpy:
1. Scans all posts during build
2. Extracts categories → creates CATEGORIES tab + archive page
3. Extracts tags → creates TAGS tab + archive page
4. Extracts dates → creates ARCHIVES tab + timeline view
5. No manual intervention needed

---

## Visual Appearance (Expected Outcome)

### Light Mode
- White/light gray background
- Dark text on light background
- Blue accent colors (Chirpy default)
- Left sidebar visible with avatar, nav, social links
- Matches Image #1 structure but with full navigation

### Dark Mode
- Charcoal/dark background
- Light text on dark background
- Muted accent colors (theme-adjusted)
- Left sidebar with same structure
- Matches Image #2 appearance

### Theme Toggle
- Moon/sun icon in header (top-right)
- Single click switches modes
- User's choice persists across sessions

---

## Implementation Approach (High-Level)

1. **Update _config.yml** — Add `avatar: ""` and `theme_mode: auto`
2. **Create _data/contact.yml** — Add GitHub and email links
3. **Create _tabs/about.md** — Add about page content
4. **Verify _posts/ front-matter** — Ensure all posts have categories and tags
5. **Build locally** — Test dark/light toggle and sidebar rendering
6. **Deploy** — Push to GitHub; GitHub Pages rebuilds with new theme configuration

---

## Success Criteria

✓ Dark/light theme toggle button visible in header  
✓ Theme preference persists across browser sessions  
✓ Sidebar displays avatar (GitHub profile picture)  
✓ Sidebar displays all navigation tabs (HOME, CATEGORIES, TAGS, ARCHIVES, ABOUT)  
✓ Social links (GitHub, email) appear in sidebar footer  
✓ CATEGORIES, TAGS, ARCHIVES tabs populate from post front-matter  
✓ About page renders correctly when ABOUT tab is clicked  
✓ No custom CSS or JavaScript required  
✓ Site builds without errors  

---

## Known Constraints

- **Front-matter compliance:** Posts must have `categories` and `tags` for archive tabs to work
- **Avatar source:** GitHub profile picture is public and auto-fetched (no local image upload)
- **Theme options:** Only three modes (auto, light, dark) — no custom color schemes
- **Sidebar order:** Tab order determined by `order:` field in front-matter (cannot customize beyond that)

---

## Testing Plan

1. **Local build:** `bundle exec jekyll serve` and verify sidebar renders
2. **Dark mode test:** Click theme toggle, confirm styling changes
3. **Navigation test:** Click each tab (CATEGORIES, TAGS, ARCHIVES, ABOUT) and verify content loads
4. **Avatar test:** Confirm GitHub avatar appears and updates if profile picture changes
5. **Social links test:** Verify email and GitHub icons are clickable and functional
6. **Browser persistence test:** Toggle theme, refresh page, verify theme preference is maintained

---

## Notes for Future Maintenance

- If you change your GitHub profile picture, the avatar updates automatically
- If you add new posts with categories/tags, CATEGORIES and TAGS tabs update automatically on next build
- Theme styling can be customized later via CSS overrides if needed (not required for this phase)
- Chirpy version upgrades should be tested locally before deploying to ensure compatibility

---

## Acceptance Criteria

- [ ] Theme toggle works (dark ↔ light)
- [ ] Sidebar shows avatar, navigation, and social links
- [ ] All navigation tabs (CATEGORIES, TAGS, ARCHIVES, ABOUT) are functional
- [ ] Site builds without errors
- [ ] Deployed site at jamie-clayton.github.io/Docs matches expected appearance
