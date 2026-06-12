---
title: AWS Cloud DevOps Setup
date: 2023-09-11 09:00:00 +1000
categories: [Tutorial, DevOps]
tags: [aws, cli, cdk, sam, cloud]
author: Jamie Clayton
redirect_from:
  - /devops/Aws-Cloud-Devops-Instructions.md
  - /devops/Aws-Cloud-Devops-Instructions
  - /devops/Aws-Cloud-Devops-Instructions.html
---
## Before You Start

- [ ] [Windows DevOps environment](/Docs/posts/2026/05/16/getting-started-windows-devops/) set up (PowerShell Core, Node.js installed)
- [ ] AWS account with IAM user credentials (Access Key ID + Secret Access Key)
- [ ] Docker Desktop running

## Success Criteria

You've completed this tutorial when:

- [ ] `aws --version` returns a version string
- [ ] `aws sts get-caller-identity` returns your AWS account ID (proves credentials work)
- [ ] `sam --version` returns a version string
- [ ] `cdk --version` returns a version string

This is a hands-on setup guide for engineers building AWS serverless infrastructure on Windows. It walks through the CLI tooling, a consistent repository layout, and a first CDK stack plus a TypeScript Lambda you can run locally with SAM. The scripts below set up a code repository that follows DevOps principles for deploying a software application to the cloud.

A couple of choices you'll make along the way. For packaging TypeScript cloud objects you can use [webpack](https://webpack.js.org/guides/getting-started/) (popular, more configuration) or [esbuild](https://esbuild.github.io/getting-started/#install-esbuild) (newer, much faster) — I default to esbuild here. For testing, write your specs in [Gherkin syntax](https://cucumber.io/docs/gherkin/reference/) to support **Behaviour-Driven Development** (BDD) and keep test results readable by non-engineers.

## Prerequisite Software

- [Nodejs 18](https://nodejs.org/en/download)
- [Aws CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Aws SAM](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Microsoft Powershell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell)
- [Microsoft Visual Code](https://code.visualstudio.com/download)
- [Visual Code Plugin - AWS Toolkit](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-toolkit-vscode)

### Windows 11 Prerequisite installation

```Powershell

winget install -e --id Microsoft.PowerShell
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id OpenJS.NodeJS.LTS
winget install -e --id Amazon.AWSCLI
winget install -e --id Amazon.SAM-CLI
winget install -e --id Docker.DockerDesktop
```

## Create a Code Repository

These steps install the global tooling you'll reuse every time you spin up a new repository, then configure npm or Yarn defaults so you don't re-type author and licence details on every `init`. Pick npm or Yarn — you don't need both.

### Npm instructions

``` Powershell
# Npm configuration
npm --version
npm install -g aws-cdk esbuild cypress gitignore jest lerna typescript webpack webpack-cli yarn 
npm config ls -l
npm config set init-author-name "{The org you work for}" -g 
npm config set init-author-email "suppor@{yourOrg}.io" -g 
npm config set init-author-url "https://dev.azure.com/{org}/{project}/_git/" -g 
# https://opensource.org/license/rpl-1-5/
npm config set init-license "RPL-1.5" -g 
```

### Yarn instructions

```Powershell
# Yarn Configuration
yarn --version
yarn global add aws-cdk cypress esbuild gitignore jest lerna readme-md-generator typescript webpack webpack-cli
yarn config list
yarn config set init-author-name "{The org you work for}" -g 
yarn config set init-author-email "suppor@{yourOrg}.io" -g
yarn config set init-author-url ""https://dev.azure.com/{org}/{project}/_git/" -g
# https://opensource.org/license/rpl-1-5/
yarn config set init-license "RPL-1.5" -g
```

## Create Software Code Repository

This script lays down a standard folder structure so every repository looks the same. A few things to know before you run it:

- It assumes a Git repository and the Visual Studio / VS Code IDE.
- It configures Lerna for a monorepo, so multiple components can be built, tested, or deployed in parallel.
- It adds a README, a licence, and an `init.ps1` script that engineers run to configure everything before working in the repo.
- The `build` and `pipeline` folders represent your DevOps CI/CD configuration as code. I'd merge them; they overlap more than they don't.

```Powershell
# TODO: Change your default code repository location
cd ~\source\repos\
ls
md vip-software-flavour
cd vip-software-flavour

# Create repository folders
md docs,infrastructure\cdk,infrastructure\terraform,pipeline,src\functions,src\website,src\endpoint,src\api

# Create standard repository files.
yarn init -p
yarn add -D gitignore readme-md-generator lerna 
npx lerna init --packages="infrastructure/cdk/*" --packages="src/*" --independent
npx gitignore VisualStudio
npx readme-md-generator
"" > LICENSE.md
"" > init.ps1
```

## Configure Package Repositories and Cloud accounts and Git Remote repositories

TODO: Add instructions for Artifact repositories and cloud vendors here.

```Powershell
 git init
 git commit
 #git remote add origin https://github.com/{Org}/{repo}.git
 #git remote add origin https://dev.azure.com/{Org}/{Project}/_git/{repo}
 git pull
 git push
 ```

## Create an AWS CDK deployment stack

This creates a simple AWS CDK stack, which synthesises to a CloudFormation stack you can deploy to your AWS account directly or through a pipeline.

For local development and debugging, pick either the [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html) or the [Serverless framework CLI](https://www.serverless.com/console/docs). The commands below use SAM.

The generated project uses Jest TypeScript tests to confirm the infrastructure-as-code behaves as expected. In an ideal world I'd test this BDD-style with cypress.io, but Jest is what the CDK template ships with.

> ⚠️ FACT-CHECK: This guide targets the `nodejs18.x` Lambda runtime and Node.js 18. AWS has since deprecated the Node.js 18 Lambda runtime — verify the current supported runtime before deploying.
{: .prompt-warning }

### AWS CDK Yarn instructions

```Powershell
cd infrastructure\cdk
cdk init app --language typescript
yarn init -p
yarn add -D @types/jest @types/node jest jest-junit ts-jest ts-node typescript
sam init --app-template hello-world-typescript --name sam-app --package-type Zip --runtime nodejs18.x

```

## Create a Typescript AWS Lambda function

This creates a Lambda function with [TypeScript and Node.js](https://docs.aws.amazon.com/lambda/latest/dg/lambda-nodejs.html#designate-es-module) and sets up Cypress BDD tests. It pulls in [Powertools for AWS Lambda (TypeScript)](https://docs.powertools.aws.dev/lambda/typescript/latest/) and bundles with esbuild rather than webpack. You can do parts of this from VS Code with the [AWS Toolkit plugin](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-toolkit-vscode) instead of the command line.

Heads up: the block below builds the SAM app, then runs it locally. Docker Desktop has to be running before `sam local` will work, and `sam local start-api` / `start-lambda` stay in the foreground until you stop them with `Ctrl+C`.

```Powershell
# Add Aws Lambda typescript
cd .\src\functions\
md get-hello-world-text
cd get-hello-world-text
tsc -v
# ES2018 support inferred from AWS Github lambda examples. 
# https://github.com/aws-samples/serverless-typescript-demo/blob/main/tsconfig.json
tsc --init --target ES2018 --strictPropertyInitialization false
yarn init -p
yarn add -D @aws-lambda-powertools/logger  @aws-lambda-powertools/metrics @aws-lambda-powertools/tracer @aws-sdk/client-lambda @types/aws-lambda @types/node aws-cdk esbuild
# Use AWS Sam to create 
sam init --app-template hello-world-typescript --name sam-app --package-type Zip --runtime nodejs18.x
cd sam-app
sam build

# Start Docker desktop, for Aws SAM CLI
docker -v
docker container ls

# AWS CLI authenticate.

# Run Lambda once with a set event
sam local invoke HelloWorldFunction --event events/event.json

# Run Lambda behind API Gateway 
sam local start-api
#sam local start-api --debug-port 5858

# Run Lambda by iteself
sam local start-lambda
#sam local start-lambda --debug-port 5858
#Ctrl+C to stop the local service.

# Test the Lambda locally and send the response to a json file.
cd ~\
aws lambda invoke --function-name HelloWorldFunction --endpoint "http://127.0.0.1:3001" AppData/Local/Temp/lambda-response.json
code ~/AppData/Local/Temp/lambda-response.json
```

## References

- [Install PowerShell on Windows, Linux, and macOS](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.3)
- [Article: Debugging Nodejs in Visual Code](https://dakshika.medium.com/remote-debug-node-js-application-using-visual-studio-code-dc0fa0b4dec4)
- [Video: Locally Debug Lambda Functions with the AWS Toolkit for VS Code](https://www.youtube.com/watch?v=FINV-VmCXms)
- [Article: Understanding Debugger Extensions in Visual Code](https://code.visualstudio.com/api/extension-guides/debugger-extension#anatomy-of-the-package.json-of-a-debugger-extension)

## Next Steps

- [Terraform on Windows](/Docs/posts/2020/03/31/terraform-on-windows/) — infrastructure as code for AWS and Azure
- [GitHub CLI Automation](/Docs/posts/2024/05/12/github-cli-automation/) — automate repository workflows
- [Azure Pipelines](/Docs/posts/2021/01/12/azure-pipelines/) — CI/CD for cloud deployments


