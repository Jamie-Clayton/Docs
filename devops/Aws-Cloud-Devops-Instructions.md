
# AWS Cloud DevOps Instructions

The following scripts create a code repository folder that followed devops principles to create the cloud infrastructure need to deploy a software application.

You can choose between [webpack](https://webpack.js.org/guides/getting-started/) (popular and complicated) or [esbuild](https://esbuild.github.io/getting-started/#install-esbuild) (new and very faster) for packaging typescript cloud objects.

Software testing should use [Gherkin syntax](https://cucumber.io/docs/gherkin/reference/) to encourage **Behaviour-Driven Development** (BDD) and enable reporting of test results in a human readable format.

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

The following script enables you setup many code repositories and installs tools that will be required to repeat this many times.

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

The following script creates a standard code repository folder structure that should help make all code repositories consistently structured.

- Assumes Git repository and use Microsf Visual Studio/Code IDE
- Configures lerna to enable multiple build, tests and deployments to occur in parallel.
- Add readme, license and a script for software engineers to configure all required components before working with the repository.
- Ideally the build and pipeline folders should merge as they represent the DevOps CICD configuration processes as code.
- Configures lerna to enable multiple components to be buit, tested or deployed. Assumes you may have multiple deployable components, like a mono repo.

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

Creates a simple AWS CDK infrastructure stack that creates a cloud formation stack that can be deployed to your AWS Account directly or indirectly.

For local development & debugging you can choose [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html) or the [Serverless framework CLI](https://www.serverless.com/console/docs)

Uses Jest type script tests to confirm your infrastructure as code works as expected. Ideally we would be testing with BDD style in cypress.io

### AWS CDK Yarn instructions

```Powershell
cd infrastructure\cdk
cdk init app --language typescript
yarn init -p
yarn add -D @types/jest @types/node jest jest-junit ts-jest ts-node typescript
sam init --app-template hello-world-typescript --name sam-app --package-type Zip --runtime nodejs18.x

```

## Create a Typescript AWS Lambda function

Creates a lambda function function with [typescript and nodejs](https://docs.aws.amazon.com/lambda/latest/dg/lambda-nodejs.html#designate-es-module), and sets up cypress BDD tests. It uses [powertools for AWS Lambda typescript](https://docs.powertools.aws.dev/lambda/typescript/latest/). Uses ESBuild rather than Webpack. Parts of this can be done in Visual Code via the [AWS Toolkit plugin](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.aws-toolkit-vscode)

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
