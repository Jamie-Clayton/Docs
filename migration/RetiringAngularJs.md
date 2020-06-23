# Guide for Migrating AngularJS 1.5.1 -to Angular 9

The following documentation provides the basic steps as well a estimated effort required to migrate an angular JS 1.5.x to a more resent edition of Angular 9+.

## Managing reference JavaScript libraries

Node Package Manager is the pragmatic choice for referencing JavaScript libraries. Older AngularJS projects often use folder copies of JavaScript libraries which make it harder to manage security risks associated with those libraries over time.

Prior to configuring NPM, you need to be aware of various decisions NPM will prompt you to answer.

### Configuring libraries with NPM

The process will prompt you to provide a series of answers to questions. Many are just meta data descriptions, but other will require some decision making prior to starting. Please read this entire section prior to executing the command

```powershell
cd solution\project\app\
npm init
```

> -- <cite>[Npm Documentation][1]

You will then configure some basic package version and naming details followed by technical options.

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

Now NPM is configured for you project, the associated Javascript packages and version need to be found and included.



### References - NPM and JavaScript Module options

[1]: [Initializing NPM](https://docs.npmjs.com/cli/init)

[2]: [Should you care about the license? (TL;DR: yes!)](https://medium.com/@vovabilonenko/licenses-of-npm-dependencies-bacaa00c8c65)

## AngularJS with Typescript

Angular 2+ leverages typescript so it's practical to consider implementing that technology into your build pipelines and development process.
The JavaScript files renamed from '*.js' to '*.ts' is rarely going to compile back to JavaScript without some build errors.

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

The **tsconfig.json** file will include a range of settings and explanations of each setting. A couple of the key settings that may need to be adjusted at this point are provided bellow.

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

[3]: [What are CJS, AMD, UMD, and ESM in Javascript?](https://dev.to/iggredible/what-the-heck-are-cjs-amd-umd-and-esm-ikm)

Understanding the module configuration help progress through the 

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