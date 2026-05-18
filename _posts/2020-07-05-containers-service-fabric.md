---
title: Containerization with Microsoft Service Fabric
date: 2020-07-05 09:00:00 +1000
categories: [Explanation, DevOps]
tags: [containers, 'service-fabric', azure]
author: Jamie Clayton
redirect_from:
  - /devops/Containers-ServiceFabric.md
  - /devops/Containers-ServiceFabric
  - /devops/Containers-ServiceFabric.html
---
The following guide provides a range of examples for dealing with Service Fabric based containers (which can be docker images).

## Service Fabric Application Rollback - PowerShell Script

```powershell
# Manually rollback a broken application upgrade.

$ConnectArgs = @{  ConnectionEndpoint = 'YourEndPointName.cloudapp.azure.com:19000';  X509Credential = $True;  StoreLocation = 'CurrentUser';  StoreName = "MY";  ServerCommonName = "YourCertServerCommonNameGoesHere";  FindType = 'FindByThumbprint';  FindValue = "TheThumprintOfTheCertificate"   }
Connect-ServiceFabricCluster @ConnectArgs
Start-ServiceFabricApplicationRollback -ApplicationName fabric:/VisualStudio.ServiceFabricProjectName
# Navigate to Service Fabric explorer and confirm the main dashboard displays "Zero Application Upgrades in Progress".
```

