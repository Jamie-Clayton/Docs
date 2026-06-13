---
title: 'Retiring AngularJS: Migration Guide'
date: 2020-04-05 09:00:00 +1000
categories: ['How-to', Frontend]
tags: [user-interface]
author: Jamie Clayton
redirect_from:
  - /code/RetiringAngularJs.md
  - /code/RetiringAngularJs
  - /code/RetiringAngularJs.html
---
This guide walks through the groundwork for migrating an AngularJS 1.5.x application to a more recent edition of Angular 9+, along with the rough effort each step takes. It's written for the engineer doing the actual migration, so it leads with the commands and warns about the traps I hit along the way.

## Managing reference JavaScript libraries

Use the Node Package Manager for referencing JavaScript libraries. Older AngularJS projects tend to keep folder copies of their libraries checked into source control, and those copies get harder to patch as the security advisories pile up over the years.

Heads up before you run anything: `npm init` asks you a series of questions, and a couple of them need a real decision, not a default. Read this whole section first.

### Configuring libraries with NPM

Most of the prompts are just metadata — name, description, author. Two of them (the test command and the licence) need an answer you've thought about, which is why this section exists. Run the init:

```powershell
cd solution\project\app\
npm init
```

> -- <cite>[Npm Documentation][1]

You'll fill in the basic package version and naming details first, then the technical options below.

### Q: Test Command

Older libraries may not have any test framework configured, so this might be skipped.

Recommended answer

```powershell
karma start karma.conf.js
```

### Q: License

This is a complicated choice, which may not be possible until you have reviewed the licensing of all the JavaScript modules you have referenced.

>Public Domain and Permissive licenses like **MIT** which allow you to do anything except sue the author
>
>Copyleft or Protective licenses like **GPL** prevent linking (see above) with proprietary software; the edge case is Network Protective licenses like Affero GPLv3 which triggers by interaction over network;
>
> -- <cite>[Vova Bilonenko][2]</cite>

Recommended Answers
If your business has a legal team, then please consult with their recommendations.

1. Corporate applications or unsure

```powershell
GPLv3
```

2. Open Source

```powershell
MIT
```

With NPM configured for your project, the next job is to find the JavaScript packages and versions you depend on and add them in.



### References - NPM and JavaScript Module options

1. [Initializing NPM](https://docs.npmjs.com/cli/init)
2. [Should you care about the license? (TL;DR: yes!)](https://medium.com/@vovabilonenko/licenses-of-npm-dependencies-bacaa00c8c65)

## AngularJS with TypeScript

Angular 2+ is built on TypeScript, so it pays to fold TypeScript into your build pipeline and day-to-day work now rather than later. Don't expect a clean run, though: rename a `*.js` file to `*.ts` and it almost never compiles straight back to JavaScript without throwing build errors at you. That's normal — the errors are TypeScript telling you what the old code was getting away with.

```powershell
# install typescript globally
npm i typescript -g

# install for the local application
npm i typescript --save-dev

# Create the local project typescript configuration file
tsc --init

# Review the tsconfig.json against the project file to ensure the typescript target and module settings match.
code tsconfig.json

# Compile the Typescript files via
tsc
```

The generated **tsconfig.json** ships with a long list of settings, each with an inline explanation. Two are worth adjusting straight away:

```json
//    Enable the generation of source maps
"sourceMap": true

//    Disable implicit checking reduce the initial workload (long term the preference is noImplicityAny: true) 
//    https://stackoverflow.com/a/52710206/342719
"noImplicitAny": false

```


> ESM is the best module format thanks to its simple syntax, async nature, and tree-shakeability.
>
> UMD works everywhere and usually used as a fallback in case ESM does not work
>
> CJS is synchronous and good for back end.
>
> AMD is asynchronous and good for front end.
>
> -- <cite>[Igor Irianto][3]

[3]: https://dev.to/iggredible/what-the-heck-are-cjs-amd-umd-and-esm-ikm "What are CJS, AMD, UMD, and ESM in Javascript?"

Getting the `module` and `target` settings right is what lets the rest of the migration proceed cleanly, so it's worth understanding which format your tooling expects before you move on.

## References

[AngularJS](https://angularjs.org/)

[Angular](https://angular.io/)

[TypeScript](https://www.typescriptlang.org/)

[NPM](https://www.npmjs.com/)

[AngularJS Style Guide - John Papa](https://github.com/johnpapa/angular-styleguide/blob/master/a1/README.md)

## Training Resources

[AngularJS Migration step by step](https://codecraft.tv/courses/angularjs-migration/)

[Enterprise AngularJs Applications and Typescript](https://www.pluralsight.com/courses/using-typescript-large-angularjs-apps)

[TypeScript for JavaScript Developers by Refactoring Part 1 of 2](https://blog.jeremylikness.com/blog/2019-03-05_typescript-for-javascript-developers-by-refactoring-part-1-of-2/)

[AngularJS JavaScript Style Guide](http://bguiz.github.io/js-standards/angularjs)

[TypeScript Import statements](https://blog.atomist.com/typescript-imports/)

[Software Licenses](https://www.gnu.org/licenses/license-list.html)

## Acknowledgements

[Asim Hussain](https://asim.dev/)

[John Papa](https://johnpapa.net/)

[Jessica Kerr](https://blog.jessitron.com/)

[Vova Bilonenko](https://medium.com/@vovabilonenko)

[Igor Irianto](https://irian.to/blogs)
