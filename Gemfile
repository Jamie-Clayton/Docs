source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "github-pages", "~> 232"

group :jekyll_plugins do
  gem "jekyll-paginate"
  gem "jekyll-redirect-from"
  gem "jekyll-seo-tag"
  gem "jekyll-archives"
  gem "jekyll-sitemap"
  gem "jekyll-feed"
  gem "jekyll-remote-theme"
end

gem "webrick", "~> 1.7" # Required for Ruby 3.0+

# Platform-specific gems for Windows
platforms :mingw, :mswin, :x64_mingw do
  gem "ffi", ">= 1.17"
  gem "tzinfo", "~> 2.0"
  gem "tzinfo-data", "~> 1.2024"
end
