---
title: Code Coverage
date: 2020-11-20 09:00:00 +1000
categories: ['How-to', Testing]
tags: [testing, coverage, dotnet]
author: Jamie Clayton
redirect_from:
  - /code/CodeCoverage.md
  - /code/CodeCoverage
  - /code/CodeCoverage.html
---
This is a working reference for measuring code coverage on .NET projects: which tools are worth a look, how NDepend turns coverage into a technical-debt figure, and the exact OpenCover command line I use because the official examples never quite work first time. It assumes you're on Windows with the .NET CLI installed.

## Tool comparison

A good overview of the landscape: [NDepend's guide to code coverage tools](https://blog.ndepend.com/guide-code-coverage-tools/).

The options I've actually weighed up, cheapest to most expensive:

1. [Fine Code Coverage](https://marketplace.visualstudio.com/items?itemName=FortuneNgwenya.FineCodeCoverage) — free Visual Studio extension
2. [dotCover](https://www.jetbrains.com/dotcover/) — $399.00 USD/Annum (dotUltimate Bundle)
3. [NCover](https://www.ncover.com/) — $658 USD/annum
4. [OpenCover](https://github.com/OpenCover/opencover) — free, open source

If you just want a number in Visual Studio, Fine Code Coverage is the path of least resistance. For CI pipelines I reach for OpenCover (see the CLI section below). The paid tools earn their keep mainly when you want the debt analysis NDepend does, which is the next section.

## Technical Debt Calculations

> Using NDepend, code rules can be written through C# LINQ queries. Applied on a code base a rule yields issues. A > dedicated debt API is proposed to estimate both the technical-debt and the annual-interest of the issue through > formulas written in C#. Both the technical-debt and annual-interest of an issue are measured in man-time.
> The technical-debt is the estimated man-time that would take to fix the issue.
> The annual-interest is the estimated man-time consumed per year if the issue is left unfixed. This provides an > estimate of the business impact of the issue.
> For example:

```C#
warnif count > 0
from m in Methods
where m.CyclomaticComplexity > 10
select new {
   m,
   m.CyclomaticComplexity,
   Debt = (3*(m.CyclomaticComplexity -10)).ToMinutes().ToDebt(),
   AnnualInterest = (m.PercentageCoverage == 100 ? 10 : 120).ToMinutes().ToAnnualInterest()
}
```

> In this example, the rule matches methods which are too complex, the complexity being measured through the > Cyclomatic Complexity code metric. We can see that:
> 
> The technical-debt is proportional to the complexity above a certain threshold.
> The annual-interest is 10 minutes per year if the method is 100% covered by tests, else it is 2 hours per year.
> Leaving a complex method both un-refactored and uncovered by tests is an error-prone situation. At best such a > situation impairs maintainability of the code, at worse it ends up in bugs at production time. The annual-interest estimates the average cost per year if the complex method is left un-refactored. This worsens if the method also is uncovered by tests. The word average is highlighted here due to the fact that, for example, out of 8 complex and untested methods maybe only one has a bug that will cost 2 days of man-work (2x8 hours) to be discovered, investigated, fixed and delivered
[^nDepend]

## Reporting Options

Raw coverage XML isn't much use on its own. To turn it into something readable — HTML reports, Azure DevOps dashboards — these are the references I keep coming back to:

- https://github.com/danielpalme/ReportGenerator
- https://dejanstojanovic.net/aspnet/2020/may/setting-up-code-coverage-reports-in-azure-devops-pipeline/
- https://docs.microsoft.com/en-us/azure/devops/pipelines/test/review-code-coverage-results?view=azure-devops
- https://www.ndepend.com/docs/code-coverage?_ga=2.62469161.461987297.1605698256-505706371.1604978997

[^nDepend]:  https://www.ndepend.com/docs/technical-debt#Debt

## Code Coverage CLI

The official docs and examples for running and saving coverage from the command line are frustrating to get right — the `-target` path in particular trips people up. Here's the OpenCover invocation that works for me against a `dotnet test` run:

```powershell
# Install Open Cover command line.
choco install opencover.portable

# Run Code Coverage tool
OpenCover.Console.exe "-target:C:\Program Files\dotnet\dotnet.exe" "-targetdir:C:\Users\$ENV:USERNAME\source\repos\" "-targetargs: test" "-output:c:\temp\results.xml" "-filter:+[*]*" "-register:user"
```

The `-target` above assumes `dotnet.exe` lives in the default install location. If yours is somewhere else, find the real path first and substitute it:

```powershell
# Find the path to dotnet.exe on the machine executing code coverage.
where dotnet
```

### References

- [OpenCover GitHub](https://github.com/OpenCover/opencover)
- [Visual Studio - code coverage extension](https://marketplace.visualstudio.com/items?itemName=FortuneNgwenya.FineCodeCoverage)
- [Dotnet cli test options](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-test)

