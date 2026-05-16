# Chirpy UX Refinement Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Configure Chirpy theme to display dark/light theme toggle, complete sidebar navigation (CATEGORIES, TAGS, ARCHIVES, ABOUT), GitHub avatar, and social links.

**Architecture:** Configuration-only approach. No custom code. Update _config.yml to enable theme features, create _data/contact.yml for social links, create _tabs/about.md for About page, verify existing posts have proper front-matter, then test locally.

**Tech Stack:** Jekyll 4.2+, Chirpy theme (already installed), Ruby/Bundler, local development server

---

## File Structure

**Files to create or modify:**

```
C:\Users\jamie\Source\Repos\Docs/
├── _config.yml                 [MODIFY] Add avatar and theme_mode
├── _data/
│   └── contact.yml            [CREATE] Social media links
├── _tabs/
│   └── about.md               [CREATE] About page
└── _posts/
    └── *.md                   [VERIFY] Ensure proper front-matter
```

---

## Tasks

### Task 1: Update _config.yml with Theme Configuration

**Files:**
- Modify: `_config.yml` (lines 1-25)

The _config.yml already has most Chirpy settings. You'll add `avatar:` (blank to use GitHub) and `theme_mode: auto` to enable the theme toggle.

- [ ] **Step 1: Read current _config.yml**

```bash
Get-Content "C:\Users\jamie\Source\Repos\Docs\_config.yml" -Head 30
```

Expected: Shows current configuration with `theme: jekyll-theme-chirpy`, author info, etc.

- [ ] **Step 2: Edit _config.yml to add avatar and theme_mode**

After the line `# Site title & metadata`, add these two new lines (in this exact order):

**Current (before):**
```yaml
# Jekyll Theme: Chirpy
theme: jekyll-theme-chirpy

# Site title & metadata
title: Continuous Improvement for Software Engineers
```

**New (after):**
```yaml
# Jekyll Theme: Chirpy
theme: jekyll-theme-chirpy

# Avatar & Theme Mode
avatar: ""
theme_mode: auto

# Site title & metadata
title: Continuous Improvement for Software Engineers
```

Use the Edit tool to add these lines between the `theme:` line and the `# Site title & metadata` comment.

- [ ] **Step 3: Verify the edit**

```bash
Get-Content "C:\Users\jamie\Source\Repos\Docs\_config.yml" -Head 15
```

Expected output should show:
```yaml
theme: jekyll-theme-chirpy

# Avatar & Theme Mode
avatar: ""
theme_mode: auto

# Site title & metadata
```

- [ ] **Step 4: Commit the change**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
git add "_config.yml"
git commit -m "config: enable Chirpy theme toggle and GitHub avatar"
```

Expected: Commit succeeds with message shown.

---

### Task 2: Create _data/contact.yml with Social Links

**Files:**
- Create: `_data/contact.yml`

This file defines the social media links that appear in the sidebar footer.

- [ ] **Step 1: Create _data directory if it doesn't exist**

```bash
New-Item -ItemType Directory -Path "C:\Users\jamie\Source\Repos\Docs\_data" -Force | Out-Null
Get-Item "C:\Users\jamie\Source\Repos\Docs\_data" | Select-Object FullName
```

Expected: Directory exists at `C:\Users\jamie\Source\Repos\Docs\_data`.

- [ ] **Step 2: Create contact.yml with social links**

Write the file `C:\Users\jamie\Source\Repos\Docs\_data\contact.yml` with this exact content:

```yaml
- type: github
  icon: "fab fa-github"
  url: "https://github.com/jamie-clayton"

- type: email
  icon: "fas fa-envelope"
  url: "mailto:jamie.clayton@jenasysdesign.com.au"
```

- [ ] **Step 3: Verify the file was created**

```bash
Get-Content "C:\Users\jamie\Source\Repos\Docs\_data\contact.yml"
```

Expected output:
```yaml
- type: github
  icon: "fab fa-github"
  url: "https://github.com/jamie-clayton"

- type: email
  icon: "fas fa-envelope"
  url: "mailto:jamie.clayton@jenasysdesign.com.au"
```

- [ ] **Step 4: Commit the new file**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
git add "_data/contact.yml"
git commit -m "feat: add social contact links (GitHub, email)"
```

Expected: Commit succeeds.

---

### Task 3: Create _tabs/about.md with About Page

**Files:**
- Create: `_tabs/about.md`

This file creates the ABOUT navigation tab and its content.

- [ ] **Step 1: Create _tabs directory if it doesn't exist**

```bash
New-Item -ItemType Directory -Path "C:\Users\jamie\Source\Repos\Docs\_tabs" -Force | Out-Null
Get-Item "C:\Users\jamie\Source\Repos\Docs\_tabs" | Select-Object FullName
```

Expected: Directory exists at `C:\Users\jamie\Source\Repos\Docs\_tabs`.

- [ ] **Step 2: Create about.md with front-matter and content**

Write the file `C:\Users\jamie\Source\Repos\Docs\_tabs\about.md` with this exact content:

```markdown
---
title: About
icon: fas fa-info-circle
order: 5
---

# About This Documentation Site

This documentation site provides instructions, notes, and guides to help with continuous software improvement.

## Purpose

We believe that engineers improve through deliberate practice, clear documentation, and shared knowledge. This site brings together best practices from DevOps, cloud architecture, code quality, and professional development.

## Topics Covered

- **DevOps & Infrastructure** — Cloud platforms, containers, CI/CD, infrastructure as code
- **Code & Architecture** — Design patterns, code coverage, licensing, production readiness
- **Soft Skills** — Resilience, mindsets, sustainability, continuous improvement methodology

## Contributing

This is a living documentation repository. If you'd like to contribute, learn more about our contribution guidelines.

---

*Last updated: 2026-05-17*
```

- [ ] **Step 3: Verify the file was created**

```bash
Get-Content "C:\Users\jamie\Source\Repos\Docs\_tabs\about.md"
```

Expected: File contains the markdown and front-matter shown above.

- [ ] **Step 4: Commit the new file**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
git add "_tabs/about.md"
git commit -m "feat: add About page with site description"
```

Expected: Commit succeeds.

---

### Task 4: Verify Existing Posts Have Proper Front-Matter

**Files:**
- Verify: `_posts/*.md` (all existing posts)

Chirpy requires posts to have `categories` and `tags` in front-matter for archive pages to generate correctly.

- [ ] **Step 1: List all posts in _posts directory**

```bash
Get-ChildItem "C:\Users\jamie\Source\Repos\Docs\_posts\*.md" | Select-Object Name
```

Expected: Shows all .md files in _posts (e.g., `2026-05-16-chirpy-migration-complete.md`).

- [ ] **Step 2: Check the front-matter of the current post**

```bash
Get-Content "C:\Users\jamie\Source\Repos\Docs\_posts\2026-05-16-chirpy-migration-complete.md" -Head 10
```

Expected output should show:
```yaml
---
title: Chirpy Theme Migration Complete
date: 2026-05-16 00:00:00 +1000
categories: [Documentation, Updates]
tags: [jekyll, chirpy, migration]
author: Jamie Clayton
---
```

Verify:
- ✓ `categories:` field exists with 1-2 values in square brackets
- ✓ `tags:` field exists with one or more values
- ✓ `date:` field has proper ISO format with timezone

- [ ] **Step 3: Verify acceptable front-matter format**

Check that the front-matter has:
- `title:` — post title (required)
- `date:` — ISO 8601 format with timezone (required for archives)
- `categories:` — array with 1-2 items (required for CATEGORIES tab)
- `tags:` — array with one or more items (required for TAGS tab)

If all posts have these fields, mark this task complete. If any posts are missing categories or tags:
- Note which posts need updates
- Update them in later tasks if needed (but for now, existing posts appear to be compliant)

- [ ] **Step 4: Confirm verification**

All posts in `_posts/` have proper front-matter with title, date (with timezone), categories, and tags. Current post (2026-05-16-chirpy-migration-complete.md) is compliant.

No commit needed for this verification task — just confirming existing content meets Chirpy requirements.

---

### Task 5: Build Jekyll Site Locally

**Files:**
- Reference: All modified files from Tasks 1-4

Build the site to verify all changes are valid and no syntax errors exist.

- [ ] **Step 1: Clean previous build artifacts**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
Remove-Item -Recurse -Force "_site" -ErrorAction SilentlyContinue
Write-Host "Build directory cleaned"
```

Expected: Previous `_site` directory removed (or confirmation it didn't exist).

- [ ] **Step 2: Run Jekyll build**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
bundle exec jekyll build --verbose
```

Expected output includes:
```
Configuration file: C:\Users\jamie\Source\Repos\Docs\_config.yml
            Source: C:\Users\jamie\Source\Repos\Docs
       Destination: C:\Users\jamie\Source\Repos\Docs\_site
 Incremental build: disabled. Enable with --incremental
      Generating...
       Jekyll Feed: Generating feed for posts
                    done in X.XXs.
 Auto-regeneration: disabled. Use --watch to enable.
```

No errors about missing theme, invalid YAML, or compilation failures.

- [ ] **Step 3: Verify key generated files exist**

```bash
Test-Path "C:\Users\jamie\Source\Repos\Docs\_site\index.html"
Test-Path "C:\Users\jamie\Source\Repos\Docs\_site\about\index.html"
Test-Path "C:\Users\jamie\Source\Repos\Docs\_site\posts\2026\05\16\chirpy-migration-complete\index.html"
```

Expected: All three return `True`.

- [ ] **Step 4: Count generated files to confirm build completeness**

```bash
@(Get-ChildItem "C:\Users\jamie\Source\Repos\Docs\_site" -Recurse -File).Count
```

Expected: Count > 50 (indicates full site was built, not just a few pages).

---

### Task 6: Start Local Development Server and Test Theme Toggle

**Files:**
- Reference: Generated `_site` from Task 5

Test the dark/light theme toggle and verify it works in the browser.

- [ ] **Step 1: Start Jekyll development server**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
bundle exec jekyll serve --incremental
```

Expected output:
```
Configuration file: C:\Users\jamie\Source\Repos\Docs\_config.yml
            Source: C:\Users\jamie\Source\Repos\Docs
       Destination: C:\Users\jamie\Source\Repos\Docs\_site
 Incremental build: disabled. Use --incremental
      Generating...
       Jekyll Feed: Generating feed for posts
                    done in X.XXs.
    Server address: http://127.0.0.1:4000
  Server running...
  Press Ctrl-C to stop.
```

Server is now running at `http://127.0.0.1:4000`.

- [ ] **Step 2: Open browser and navigate to local site**

Open your browser and go to: `http://127.0.0.1:4000`

Expected: You see the homepage with:
- Left sidebar visible
- Title "Continuous Improvement for Software Engineers"
- Blog post ("Chirpy Theme Migration Complete")
- Right sidebar with "Recently Updated" and "Trending Tags"

- [ ] **Step 3: Verify theme toggle button exists**

In the top-right corner of the header, look for a **moon/sun icon** (the theme toggle button).

Expected: Icon is visible next to search and other header icons.

- [ ] **Step 4: Click theme toggle button**

Click the moon/sun icon in the top-right header.

Expected: Page switches from light theme to dark theme (or vice versa):
- Background color changes (light → dark or dark → light)
- Text color inverts
- Sidebar styling changes
- All content remains readable in both modes

- [ ] **Step 5: Refresh page and verify theme persists**

Press `F5` or `Ctrl+R` to refresh the page.

Expected: Theme preference is maintained. If you switched to dark mode, the page loads in dark mode. Browser's localStorage saved your preference.

- [ ] **Step 6: Stop server**

In the terminal where Jekyll is running, press `Ctrl+C`.

Expected: Server stops with message "Jekyll 4.2.x please stop the server (Ctrl+C)."

---

### Task 7: Test Navigation Tabs and Sidebar Structure

**Files:**
- Reference: Built site from Task 5

Test that all navigation tabs (CATEGORIES, TAGS, ARCHIVES, ABOUT) are present and functional. Verify sidebar displays correctly.

- [ ] **Step 1: Start server again for testing**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
bundle exec jekyll serve --incremental
```

Expected: Server starts at `http://127.0.0.1:4000`.

- [ ] **Step 2: Verify sidebar navigation structure**

Open `http://127.0.0.1:4000` in browser. Look at the **left sidebar**. Verify it shows:

```
[GitHub Avatar]
  ↓
Continuous Improvement
for Software Engineers
(tagline below)
  ↓
Navigation Icons:
🏠 HOME
📁 CATEGORIES
🏷️  TAGS
📅 ARCHIVES
ℹ️  ABOUT
  ↓
Social Icons:
🐙 (GitHub)
📧 (Email)
```

Expected: All elements visible and properly aligned.

- [ ] **Step 3: Click CATEGORIES tab**

Click the **CATEGORIES** icon/link in the left sidebar.

Expected: Browser navigates to `/categories` and displays posts organized by category. Should show "Documentation" and "Updates" as categories (from the existing post).

- [ ] **Step 4: Click TAGS tab**

Click the **TAGS** icon/link in the left sidebar.

Expected: Browser navigates to `/tags` and displays posts organized by tags. Should show "jekyll", "chirpy", "migration" as tags (from the existing post).

- [ ] **Step 5: Click ARCHIVES tab**

Click the **ARCHIVES** icon/link in the left sidebar.

Expected: Browser navigates to `/archives` and displays posts organized by date/timeline. Should show the "2026-05" entry with the migration post.

- [ ] **Step 6: Click ABOUT tab**

Click the **ABOUT** icon/link in the left sidebar.

Expected: Browser navigates to `/about` and displays the content from `_tabs/about.md`:
- Title "About This Documentation Site"
- Sections: Purpose, Topics Covered
- Professional appearance

- [ ] **Step 7: Verify HOME tab returns to homepage**

Click the **HOME** icon in the sidebar.

Expected: Browser returns to homepage with post list.

- [ ] **Step 8: Stop server**

Press `Ctrl+C` to stop the development server.

---

### Task 8: Test Social Links and Avatar Display

**Files:**
- Reference: Built site from Task 5

Verify that social links (GitHub, email) are clickable and avatar displays correctly.

- [ ] **Step 1: Start server again for final testing**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
bundle exec jekyll serve --incremental
```

Expected: Server running at `http://127.0.0.1:4000`.

- [ ] **Step 2: Verify GitHub avatar displays**

Open `http://127.0.0.1:4000` in browser. Look at the **top of the left sidebar**.

Expected: A circular profile picture is visible (your GitHub profile picture, automatically fetched from github.com/jamie-clayton).

- [ ] **Step 3: Test GitHub social link**

Scroll to the **bottom of the left sidebar** and find the **GitHub icon** (Octocat logo or "🐙").

Click it.

Expected: Opens `https://github.com/jamie-clayton` in a new tab.

- [ ] **Step 4: Test email social link**

In the left sidebar footer, find the **email icon** (envelope or "📧").

Click it.

Expected: Opens your default email client with `jamie.clayton@jenasysdesign.com.au` as the recipient (or shows email composer dialog).

- [ ] **Step 5: Verify links in light and dark mode**

Toggle the theme to dark mode (click theme button). Verify:
- Avatar still displays correctly (may have different styling/border in dark mode)
- Social icons are still visible and clickable
- Icons contrast well against the dark background

- [ ] **Step 6: Stop server**

Press `Ctrl+C` to stop the development server.

---

### Task 9: Verify All Success Criteria Are Met

**Files:**
- Reference: Local build and testing from Tasks 5-8

Final verification that all acceptance criteria from the design spec are complete.

- [ ] **Success 1: Theme toggle works (dark ↔ light)**

From Task 6 testing:
- ✓ Theme toggle button visible in header
- ✓ Clicking toggles between light and dark mode
- ✓ Browser remembers user's choice

**Status:** ✓ Complete

- [ ] **Success 2: Sidebar shows avatar, navigation, and social links**

From Tasks 7-8 testing:
- ✓ GitHub avatar displays at top of sidebar
- ✓ Navigation items (HOME, CATEGORIES, TAGS, ARCHIVES, ABOUT) visible
- ✓ Social icons (GitHub, email) display in sidebar footer

**Status:** ✓ Complete

- [ ] **Success 3: All navigation tabs are functional**

From Task 7 testing:
- ✓ CATEGORIES tab navigates to category archive
- ✓ TAGS tab navigates to tag archive
- ✓ ARCHIVES tab navigates to date-based archive
- ✓ ABOUT tab displays about page
- ✓ HOME tab returns to homepage

**Status:** ✓ Complete

- [ ] **Success 4: Site builds without errors**

From Task 5 testing:
- ✓ `bundle exec jekyll build` completes successfully
- ✓ No YAML syntax errors
- ✓ No missing file errors
- ✓ All key pages generated (_site/index.html, _site/about/index.html, etc.)

**Status:** ✓ Complete

- [ ] **Success 5: Deployed site matches expected appearance**

From Tasks 6-8 testing:
- ✓ Light mode appearance professional and clean
- ✓ Dark mode appearance matches reference (Image #2)
- ✓ Sidebar layout matches Chirpy design
- ✓ All UI elements properly styled and aligned

**Status:** ✓ Complete

---

### Task 10: Final Commit and Verification

**Files:**
- Reference: All changes from Tasks 1-4

Commit any final changes and verify git history.

- [ ] **Step 1: Check git status**

```bash
cd "C:\Users\jamie\Source\Repos\Docs"
git status
```

Expected: All changes already committed from Tasks 1-4. Output shows "nothing to commit, working tree clean" or lists any uncommitted files from the _site directory (which should be ignored).

- [ ] **Step 2: Review commit log**

```bash
git log --oneline -5
```

Expected output shows recent commits:
```
xxxx (HEAD -> master) feat: add About page with site description
xxxx feat: add social contact links (GitHub, email)
xxxx config: enable Chirpy theme toggle and GitHub avatar
xxxx docs: add Chirpy UX refinement design specification
xxxx ci: install all required Jekyll plugins from _config.yml
```

- [ ] **Step 3: Verify _site is in .gitignore**

```bash
Get-Content "C:\Users\jamie\Source\Repos\Docs\.gitignore" | Select-String "_site"
```

Expected: Shows `_site` or `/_site` in .gitignore (so generated files aren't committed).

- [ ] **Step 4: Confirmation**

All configuration changes committed to git. Site is ready for GitHub Pages deployment.

---

## Self-Review Checklist

**Spec Coverage:**
- ✓ Task 1: Update _config.yml with avatar and theme_mode — implements "Configuration & Setup Strategy"
- ✓ Task 2: Create _data/contact.yml — implements social links
- ✓ Task 3: Create _tabs/about.md — implements About page
- ✓ Task 4: Verify posts front-matter — implements navigation auto-generation
- ✓ Tasks 5-8: Build, test, and verify — implements success criteria testing
- ✓ Task 9: Verify all success criteria — comprehensive acceptance check
- ✓ Task 10: Final commit — documentation of changes

**Placeholder Scan:**
- ✓ No "TBD", "TODO", "implement later" found
- ✓ All YAML examples complete and valid
- ✓ All commands shown with exact paths
- ✓ All expected outputs documented
- ✓ No "add appropriate error handling" vagueness — specific verification steps

**File Path Consistency:**
- ✓ All paths use `C:\Users\jamie\Source\Repos\Docs\` (Windows format)
- ✓ File names match spec (contact.yml, about.md, _config.yml)
- ✓ Directory structure (_data, _tabs, _posts) matches Chirpy conventions

**Task Independence:**
- ✓ Tasks 1-4 are sequential configuration/setup (must run in order)
- ✓ Tasks 5-8 are testing (depend on 1-4 being complete)
- ✓ Task 9 is verification (depends on 5-8)
- ✓ Task 10 is documentation (final cleanup)

**Execution Readiness:**
- ✓ Each step takes 2-5 minutes
- ✓ Commands are copy-paste ready
- ✓ Expected outputs are specific and verifiable
- ✓ Checkboxes enable task tracking

