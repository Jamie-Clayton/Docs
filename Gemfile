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

# Platform-specific gems for Windows
platforms :mingw, :mswin, :x64_mingw do
  gem "ffi", ">= 1.17"
end
