---
title: Azure Pipelines
date: 2021-01-12 09:00:00 +1000
categories: [Reference, DevOps]
tags: [azure, 'ci-cd', pipelines]
author: Jamie Clayton
redirect_from:
  - /devops/AzurePipelines.md
  - /devops/AzurePipelines
  - /devops/AzurePipelines.html
---
A reference of YAML patterns and snippets for Azure DevOps pipeline configuration. Copy what you need; each snippet stands on its own.

## Quick navigation

| Pattern | Section |
|---------|---------|
| Conditional template selection | [Conditional templates](#conditional-templates) |
| Multi-repository builds | [Multi-repository builds](#multi-repository-builds) |
| Pipeline design principles | [Design principles](#design-principles) |

## Design principles

* Keep it simple
* Use variables and parameters
* Define repositories explicitly (needed for mixed `dev.azure.com` tenant subscriptions)
* Minimise nested template YAML — every level of nesting is another context switch when you're debugging

## Conditional templates

Use parameters and `${{ if }}` expressions to pick a template at compile time. Here the pipeline swaps between an experimental and a stable build based on a boolean parameter.

{% raw %}
```yaml
#azure-pipeline.yml
parameters:
- name: experimentalTemplate
  displayName: 'Use experimental build process?'
  type: boolean
  default: false

steps:
- ${{ if eq(parameters.experimentalTemplate, true) }}:
  - template: experimental.yml
- ${{ if not(eq(parameters.experimentalTemplate, true)) }}:
  - template: stable.yml
```
{% endraw %}

## Multi-repository builds

A pipeline can pull templates and code from more than one repository. The first run prompts you to grant permission to each external repository resource before it'll check them out — expect that gate the first time, it's not an error.

```Yaml
resources:
  repositories:
    - repository: DeploymentTemplates #alias name
      type: git #type of repository
      name: deployment-files #repository name
      ref: 'refs/heads/main' #git branch reference
stages:
  - stage: 'CIBuild'
    displayName: 'CI  Service'
    jobs:
      - job: CI_Service
        displayName: CI Service
        continueOnError: false
        pool:
          displayName: "CI Service"
          name: Default
        workspace:
          clean: all
        timeoutInMinutes: 120
        cancelTimeoutInMinutes: 2
    steps:
    - template: DevOps/Tasks/_DotNetCoreCLI.yml@DeploymentTemplates
      parameters:
        displayName: 'Restore .NetCore Projects'
        projects:  '**/MicroServices/**/*.API.csproj'
        arguments: '--packages $(Build.SourcesDirectory)\packages'
        command: restore
     
    - template: DevOps/Tasks/_DotNetCoreCLI.yml@DeploymentTemplates
      parameters:
        displayName: 'Build .NetCore Projects'
        projects:  '**/*.csproj'
        arguments: '--configuration $(BuildConfiguration) --output $(Build.SourcesDirectory)\bin\$(BuildConfiguration)'
        command: build
```

## References

- [Multiple Repositories](https://prcode.co.uk/2020/10/14/azure-devops-pipeline-templates-and-external-repositories/)
- [Azure Pipeline Docs - Resources](https://docs.microsoft.com/en-us/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema%2Cparameter-schema#resources)
- [Azure Pipeline Docs - Repository checkout](https://docs.microsoft.com/en-us/azure/devops/pipelines/repos/multi-repo-checkout?view=azure-devops#repository-details)
- [Documentation Style Guides](https://www.writethedocs.org/guide/writing/style-guides/)

