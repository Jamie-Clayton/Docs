---
title: Software Licensing
date: 2020-09-22 09:00:00 +1000
categories: [Explanation, Engineering]
tags: [licensing, opensource]
author: Jamie Clayton
redirect_from:
  - /code/Licensing.md
  - /code/Licensing
  - /code/Licensing.html
---
## Why licensing is your problem, not the lawyer's

The license on a piece of code decides whether you're allowed to use it, change it, and ship it. Get that wrong and the cost lands on the business, not on the legal team that reviewed it after the fact. So I treat licensing as an engineering decision, made at the point the code is pulled in.

You'll spend your career writing code and pulling in other people's. Every dependency you add carries terms, and some of those terms are sticky enough to dictate how you're allowed to distribute your own product. A permissive license (MIT, Apache, BSD) lets you do almost anything as long as you keep the notice. A copyleft license (GPL and its relatives) can require you to release your changes — sometimes your whole product — under the same terms. That distinction is the one that bites people, usually right before a release.

My rule of thumb: know the license before the dependency goes in, not when someone asks at audit time. If you're publishing your own code, pick the license deliberately rather than letting the repo default to "none," which is the most restrictive option of all.

## References

[Quick way to choose your license](https://choosealicense.com/licenses/)

[End User License Agreements - EULA](https://wiki.eltima.com/software-licenses/source-code-eula.html)

[EULA Wikipedia](https://en.wikipedia.org/wiki/End-user_license_agreement)
