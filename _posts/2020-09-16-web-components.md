---
title: Web Components
date: 2020-09-16 09:00:00 +1000
categories: [Explanation, Frontend]
tags: [webcomponents, browser, frontend]
author: Jamie Clayton
redirect_from:
  - /code/WebComponents.md
  - /code/WebComponents
  - /code/WebComponents.html
---
Web Components belong on your technology radar. The JavaScript browser ecosystem churns constantly, frameworks come and go, and Web Components are one of the few component models that outlive whichever SPA framework is fashionable this year — they ship as a browser standard, not a library you have to keep upgrading.

Here is what they buy you, and where they stop:

* Components built in a framework-agnostic way, so they survive a framework migration.
* They work inside large Content Management Systems (CMS) and within Markdown.
* They borrow the component architecture style of popular SPA frameworks and pair with modern JavaScript transpilers like TypeScript.
* They are cross-browser compatible. The standard dates to 2011 and is now supported by all modern browsers.
* Component development is quick and independent of any larger application.

The honest catch: Web Components do **not** provide data binding natively — that is where your framework still earns its keep. You can generate them from [Angular](https://angular.io/guide/elements), [React](https://reactjs.org/) ([Preact](https://preactjs.com/) could be substituted) or [Vue](https://vuejs.org/), but weigh the output size and runtime performance before you do; wrapping a full framework to emit one component is often a poor trade.

## References

[Web Components Org](https://www.webcomponents.org/introduction#libraries-for-building-web-components)

[Building Web Components](https://developers.google.com/web/fundamentals/web-components)

[The Polymer Project - Web Component builder](https://www.polymer-project.org)

[Web Components - Crash Course](https://www.youtube.com/watch?v=PCWaFLy3VUo)

[Web Components - It's about time by Erin Zimmer](https://www.youtube.com/watch?v=zZ1YMJydqR0)

[Star Rating - Web Component walk through](https://www.thinktecture.com/en/web-components/native-web-components-without-framework/)

[Compare framework approaches for Web Components](https://webcomponents.dev/blog/all-the-ways-to-make-a-web-component-april2020/)

[How CommonJS is making your bundles larger](https://web.dev/commonjs-larger-bundles/)
