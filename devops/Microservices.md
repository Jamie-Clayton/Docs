<p><a target="_blank" href="https://app.eraser.io/workspace/6kUEFQFheT5cFfg5JyRB" id="edit-in-eraser-github-link"><img alt="Edit in Eraser" src="https://firebasestorage.googleapis.com/v0/b/second-petal-295822.appspot.com/o/images%2Fgithub%2FOpen%20in%20Eraser.svg?alt=media&amp;token=968381c8-a7e7-472a-8ed6-4a6626da5501"></a></p>

# Dotnet Microservices
## Project Instructions
```Powershell
dotnet new webapi -f 5.0 -lang "C#" -au "Windows"
dotnet new xunit -f 5.0 -lang "C#"
dotnet sln add Software.API/Software.API.csproj

dotnet add package AspNetCore.HealthChecks.UI.Client --version 5.0.1
dotnet add package AspNetCore.HealthChecks.Rabbitmq --version 5.0.1
dotnet add package System.Data.SqlClient --version 4.8.2

Test-NetConnection -ComputerName RABBITMQServerName -Port 5672
```
![Microservice Architecture - .net](/.eraser/6kUEFQFheT5cFfg5JyRB___M7HUYofgzENvEiuTW19wQsQiDfM2___---figure---8CgCgbVNT67pfJB-HwU1r---figure---thwgJSGh_qN0jFQFwCiG8w.png "Microservice Architecture - .net")

## References
- [﻿Health Monitoring](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/monitor-app-health)  
- [﻿Health Check walk through](https://www.hanselman.com/blog/how-to-set-up-aspnet-core-22-health-checks-with-beatpulses-aspnetcorediagnosticshealthchecks) 






<!-- eraser-additional-content -->
## Diagrams
<!-- eraser-additional-files -->
<a href="/devops/Microservices-Scalable Microservices - DotNet-1.eraserdiagram" data-element-id="J_oCPCXo0dDfSEIT7rfio"><img src="/.eraser/6kUEFQFheT5cFfg5JyRB___M7HUYofgzENvEiuTW19wQsQiDfM2___---diagram----d11cc52afa9fa877215b58b3447a03c0-Scalable-Microservices---DotNet.png" alt="" data-element-id="J_oCPCXo0dDfSEIT7rfio" /></a>
<!-- end-eraser-additional-files -->
<!-- end-eraser-additional-content -->
<!--- Eraser file: https://app.eraser.io/workspace/6kUEFQFheT5cFfg5JyRB --->