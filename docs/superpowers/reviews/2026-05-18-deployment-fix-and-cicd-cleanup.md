# Deployment Fix & CI/CD Cleanup

**Date:** 2026-05-18
**Status:** Site live and fully working at https://jamie-clayton.github.io/Docs/

## What Was Actually Broken

The build had been reporting "success" for several runs, but the deployed site was unstyled and asset-broken. Two independent root causes:

### Issue 1: GitHub Pages source was set to "legacy" (branch)

`repos/Jamie-Clayton/Docs/pages` returned `"build_type": "legacy"`. That means every push triggered **two** workflows:

- Our custom `Build and deploy to GitHub Pages` (`.github/workflows/pages.yml`) — succeeded
- GitHub's built-in `pages-build-deployment` running Jekyll 3.10.0 — **failed** with `jekyll-theme-chirpy theme could not be found`, and **its output was what GitHub Pages actually served**

Our custom workflow's artifact never reached the live URL.

**Fix:** `gh api -X PUT repos/Jamie-Clayton/Docs/pages -f "build_type=workflow"`

After this, only the custom workflow runs, and its artifact is the deployed site.

### Issue 2: Missing `baseurl` in `_config.yml`

`url:` was set to `https://jamie-clayton.github.io/Docs` (with the subpath baked in). There was no `baseurl:`. Chirpy renders asset paths through Jekyll's `relative_url` / `absolute_url` filters, which prepend `baseurl`. With no `baseurl`, every `/assets/css/...`, `/assets/js/...`, and favicon URL resolved at the domain root instead of `/Docs/`, returning 404s and producing an unstyled page.

**Fix:**

```yaml
url: "https://jamie-clayton.github.io"
baseurl: "/Docs"
```

## Verification (Post-Fix)

All 21 critical URLs return HTTP 200, including:

- Homepage, CATEGORIES, TAGS, ARCHIVES, ABOUT
- The post: `/posts/2026/05/16/chirpy-migration-complete/`
- All three trending tags
- Both category pages (`/categories/documentation/`, `/categories/updates/`)
- CSS, JS bundles, all favicons, search index, feed, sitemap, robots.txt, 404

Sitemap output matches expectations. Chirpy sidebar, search, post cards, and footer all render correctly.

## CI/CD State (After Cleanup)

**Workflow:** `.github/workflows/pages.yml` — the single source of truth.

| Step | Action | Version |
|------|--------|---------|
| Checkout | `actions/checkout` | v6 |
| Setup Pages | `actions/configure-pages` | v6 |
| Setup Ruby | `ruby/setup-ruby` | v1 (Ruby 3.3, `bundler-cache: true`) |
| Build | `bundle exec jekyll build --destination ./_site` | — |
| Upload artifact | `actions/upload-pages-artifact` | v5 |
| Deploy | `actions/deploy-pages` | v5 |

All actions are on Node.js 24-compatible major versions — the prior Node 20 deprecation warnings are resolved.

**Triggers:** push to `master` or manual `workflow_dispatch`. Concurrency group `pages` cancels in-progress runs to prevent overlap.

**No other workflows are configured.** The legacy `pages-build-deployment` does not run because `build_type=workflow` is set on the Pages config.

## What Lives Where

| Concern | Location |
|---------|----------|
| Jekyll version pin | `Gemfile` (`jekyll ~> 4.2`) |
| Theme version pin | `Gemfile` (`jekyll-theme-chirpy ~> 7.0`) |
| Resolved lockfile | `Gemfile.lock` (includes `x64-mingw-ucrt` and `x86_64-linux`, Bundler 2.6.9) |
| Site config | `_config.yml` |
| Build workflow | `.github/workflows/pages.yml` |
| GitHub Pages source | Workflow (set via API, not in repo) |

## Known Non-Issues

- `actions/checkout@v6` shows no Node 20 warning. Earlier runs (pre-bump) warned about Node 20 deprecation effective June 2nd, 2026. Resolved.
- `docs/superpowers/` is excluded from Jekyll processing via `_config.yml` and from git via being untracked. Working notes live here; they don't ship to the site.

## Prior Misleading Doc

`2026-05-17-build-success-summary.md` previously claimed the deployment was working after the Gemfile.lock fix. That was incorrect — the build was succeeding but its artifact wasn't reaching the live URL because of Issue 1 above. That file has been removed and superseded by this document.
