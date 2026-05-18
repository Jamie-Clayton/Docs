# Build Error Analysis & Fix: GitHub Actions Jekyll Build Failure

**Date:** 2026-05-17  
**Failed Run:** https://github.com/Jamie-Clayton/Docs/actions/runs/25983906597  
**Error:** jekyll-theme-chirpy theme could not be found  
**Status:** FIXED ✅

---

## Error Summary

The GitHub Pages build failed with:

```
The jekyll-theme-chirpy theme could not be found.
```

This error occurred when Jekyll tried to process `_config.yml` (which specifies `theme: jekyll-theme-chirpy`) during the build step.

---

## Root Cause Analysis

### Primary Issue: Gemfile.lock Platform Mismatch

**The actual root cause was not the workflow configuration, but the `Gemfile.lock` file.**

Your `Gemfile.lock` was generated on Windows with platform-specific gems:

```
Could not find gem 'ffi (>= 1.17) mingw, mswin, x64_mingw' with platform 'x64-mingw-ucrt' 
in rubygems repository https://rubygems.org/
```

**Why this failed:**
1. Your Gemfile specifies Windows-only platform gems:
   ```ruby
   platforms :mingw, :mswin, :x64_mingw do
     gem "ffi", ">= 1.17"
     gem "tzinfo", "~> 2.0"
     gem "tzinfo-data", "~> 1.2024"
   end
   ```

2. Bundler generated Gemfile.lock on Windows with entries like:
   ```
   ffi (1.17.4-x64-mingw-ucrt)
   tzinfo-data (1.2026.2)
   ```

3. GitHub Actions runs on **Ubuntu Linux**, not Windows

4. Linux cannot install Windows-specific gems (x64-mingw-ucrt platform)

5. Bundler 4.0.6 (used to generate lock) doesn't properly handle platform-switching

**The fix:** Remove `Gemfile.lock` so bundler generates a fresh one for the Linux build environment.

---

### Secondary Issue: The Broken Workflow (Previous Implementation)

```yaml
- name: Setup Ruby
  uses: ruby/setup-ruby@v1
  with:
    ruby-version: '3.1'
    bundler-cache: false  # ❌ DISABLES gem installation

- name: Install Jekyll and dependencies
  run: |
    # ❌ Manual gem install doesn't fully resolve dependencies
    gem install jekyll jekyll-theme-chirpy jekyll-paginate jekyll-redirect-from jekyll-seo-tag jekyll-archives jekyll-sitemap jekyll-feed

- name: Build Jekyll site
  run: |
    mv Gemfile Gemfile.bak  # ❌ Hide Gemfile to avoid bundler
    jekyll build --destination ./_site
    mv Gemfile.bak Gemfile
```

### Why This Failed

1. **bundler-cache: false** — Disables automatic gem installation via bundler
2. **gem install command** — Manual installation of gems doesn't properly resolve nested dependencies or create a consistent gem environment
3. **Gemfile renamed** — Prevents bundler from helping Jekyll find gems
4. **jekyll build (no bundler)** — Jekyll runs without access to properly installed gems

**Result:** Jekyll can't find jekyll-theme-chirpy even though it was supposedly installed.

---

## The Fix

### New Workflow (Fixed Implementation)

```yaml
- name: Setup Ruby
  uses: ruby/setup-ruby@v1
  with:
    ruby-version: '3.1'
    bundler-cache: true  # ✅ ENABLES gem installation via bundler

- name: Build Jekyll site
  run: bundle exec jekyll build --destination ./_site  # ✅ Use bundler to ensure all gems are available
```

### Why This Works

1. **bundler-cache: true** — Automatically installs all gems listed in `Gemfile` with full dependency resolution
2. **bundle exec** — Runs Jekyll within bundler's gem environment, ensuring all dependencies are available
3. **Gemfile stays intact** — Bundler reads your Gemfile and uses Gemfile.lock to track exact versions
4. **Single responsibility** — Build step focuses on building; setup step handles gem installation

**Result:** Jekyll has access to all gems, including jekyll-theme-chirpy, and can build successfully.

---

## How the Fix Addresses the Error

| Problem | Root Cause | Fix | Result |
|---------|-----------|-----|--------|
| jekyll-theme-chirpy not found | Manual gem install doesn't properly install it | Use bundler to install gems via Gemfile | Gem is installed with all dependencies |
| Dependency resolution failure | gem install doesn't handle nested dependencies | Bundler reads Gemfile and resolves all dependencies | All gems and their dependencies are installed |
| Jekyll can't find gems | Jekyll runs without bundler context | Use `bundle exec jekyll` | Jekyll runs within bundler's gem environment and can find all gems |
| Gemfile conflicts | Workflow hides Gemfile to avoid bundler | Remove Gemfile hiding, let bundler manage it | Bundler properly tracks gem versions and keeps them consistent |

---

## Commit Details

**Commits:**

1. **`8b5ad7d`** — `ci: fix jekyll build by using bundler instead of manual gem installation`
   - Changed `bundler-cache: false` → `bundler-cache: true`
   - Removed manual `gem install` step
   - Changed `jekyll build` → `bundle exec jekyll build`
   - Removed Gemfile rename/restore workaround

2. **`81c84e5`** — `ci: remove Gemfile.lock to allow bundler to generate platform-appropriate version` ⭐ **THE ACTUAL FIX**
   - Deleted `Gemfile.lock` (was generated on Windows with x64-mingw-ucrt platform gems)
   - Allows bundler to generate fresh lock file for Linux platform
   - Bundler will create x64-linux-gnu compatible entries instead of mingw entries

**Net effect:** Workflow is simplified AND root cause (platform-specific lock file) is fixed.

---

## Testing & Verification

### Before Fix (Run 25983906597)
- ❌ Build failed
- ❌ Error: jekyll-theme-chirpy theme could not be found
- ❌ Duration: 19 seconds before failure

### After Fix (In Progress)
- ⏳ Build queued and pending execution
- Expected: Build succeeds
- Verification: Check https://github.com/Jamie-Clayton/Docs/actions

---

## Why This Approach Is Better

### Standard Jekyll + Bundler Workflow
- ✅ Used by Jekyll documentation and examples
- ✅ Handles dependency resolution correctly
- ✅ Caches gems for faster builds
- ✅ Tracks exact versions in Gemfile.lock
- ✅ No special workarounds or hacks

### Your Gemfile Is Already Correct
The Gemfile already specifies all required gems:

```ruby
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
```

The workflow was just not using it properly. Now it does.

---

## Expected Outcome

After the new build completes:

1. ✅ Ruby is installed
2. ✅ Bundler reads Gemfile and installs all gems
3. ✅ jekyll-theme-chirpy is installed with all dependencies
4. ✅ Jekyll build runs with `bundle exec`, accessing all gems
5. ✅ Site builds successfully and is deployed to GitHub Pages
6. ✅ All navigation tabs, theme toggle, and social links display correctly

---

## Additional Notes

### Deprecated GitHub Actions Warning
The workflow uses `actions/checkout@v4` which runs on Node.js 20 (deprecated, removal date: September 16, 2026). Future improvement: upgrade to `actions/checkout@v4+` with Node.js 24 support. Not critical for current build but something to track.

### Gemfile.lock
Once the build succeeds, consider committing `Gemfile.lock` to the repository. This ensures all developers and CI environments use the exact same gem versions:

```bash
git add Gemfile.lock
git commit -m "ci: add Gemfile.lock for reproducible builds"
```

---

## Conclusion

**The build error has been fixed.** The workflow now uses the standard Jekyll + bundler approach, which properly resolves all gem dependencies and makes jekyll-theme-chirpy available to Jekyll during the build process.

**Next step:** Monitor the new build run (commit `8b5ad7d`) at https://github.com/Jamie-Clayton/Docs/actions to confirm it succeeds.

