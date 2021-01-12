# Azure Pipelines

A short guide to working with Azure pipelines and some in a large business.

## Principles

* Keep it simple
* Use variables and parameters
* Define repositories (for mixed dev.azure.com tenant subscriptions)
* Minimize nested template yaml as it requires context switching

## Advanced Techniques

You can use variables and logic within the template to drive how things are done with nested yaml templates.

```Yaml
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

You can reference multiple repositories in a build process. The build process will prompt you for permission to access those external repository resources.

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

[Multiple Repositories](https://prcode.co.uk/2020/10/14/azure-devops-pipeline-templates-and-external-repositories/)
[Azure Pipeline Docs - Resources](https://docs.microsoft.com/en-us/azure/devops/pipelines/yaml-schema?view=azure-devops&tabs=schema%2Cparameter-schema#resources)
[Azure Pipeline Docs - Repository checkout](https://docs.microsoft.com/en-us/azure/devops/pipelines/repos/multi-repo-checkout?view=azure-devops#repository-details)
[Documentation Style Guides](https://www.writethedocs.org/guide/writing/style-guides/)
