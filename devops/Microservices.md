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
## References
- [﻿Health Monitoring](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/monitor-app-health) 
- [﻿Health Check walk through](https://www.hanselman.com/blog/how-to-set-up-aspnet-core-22-health-checks-with-beatpulses-aspnetcorediagnosticshealthchecks) 
![Microservice Architecture - .net](/.eraser/6kUEFQFheT5cFfg5JyRB___M7HUYofgzENvEiuTW19wQsQiDfM2___---figure---jNSz7WP9a5r2VTY0ZChsG---figure---thwgJSGh_qN0jFQFwCiG8w.png "Microservice Architecture - .net")




<!-- eraser-additional-content -->
## Diagrams
<!-- eraser-additional-files -->
<a href="/devops/Microservices-.NET Microservice Architecture-1.eraserdiagram" data-element-id="J_oCPCXo0dDfSEIT7rfio"><img src="/.eraser/6kUEFQFheT5cFfg5JyRB___M7HUYofgzENvEiuTW19wQsQiDfM2___---diagram----9aab31d8344ba410ed4c2e3063e7f083--NET-Microservice-Architecture.png" alt="" data-element-id="J_oCPCXo0dDfSEIT7rfio" /></a>
<!-- end-eraser-additional-files -->
<!-- end-eraser-additional-content -->
<!--- Eraser file: https://app.eraser.io/workspace/6kUEFQFheT5cFfg5JyRB --->