---
title: Containerization with Microsoft Service Fabric
date: 2020-07-05 09:00:00 +1000
categories: [Explanation, DevOps]
tags: [containers, azure]
author: Jamie Clayton
redirect_from:
  - /devops/Containers-ServiceFabric.md
  - /devops/Containers-ServiceFabric
  - /devops/Containers-ServiceFabric.html
---
This is a how-to for operators running containerised applications (which can be Docker images) on Microsoft Service Fabric. It covers one task I reach for often: manually rolling back an application upgrade that's gone wrong mid-flight.

## Before you start

You'll need:

- The Service Fabric PowerShell module loaded (it ships with the Service Fabric SDK).
- The client certificate that authenticates you to the cluster, installed in your `CurrentUser\MY` store. You'll need its thumbprint.
- The cluster's connection endpoint and the server certificate common name.

## Roll back a broken application upgrade

When an upgrade is failing or stuck, this connects to the cluster and starts a rollback to the last known-good version.

```powershell
# Manually rollback a broken application upgrade.

$ConnectArgs = @{  ConnectionEndpoint = 'YourEndPointName.cloudapp.azure.com:19000';  X509Credential = $True;  StoreLocation = 'CurrentUser';  StoreName = "MY";  ServerCommonName = "YourCertServerCommonNameGoesHere";  FindType = 'FindByThumbprint';  FindValue = "TheThumprintOfTheCertificate"   }
Connect-ServiceFabricCluster @ConnectArgs
Start-ServiceFabricApplicationRollback -ApplicationName fabric:/VisualStudio.ServiceFabricProjectName
# Navigate to Service Fabric explorer and confirm the main dashboard displays "Zero Application Upgrades in Progress".
```

Swap the placeholder values (`YourEndPointName`, the thumbprint, the common name, and the `fabric:/...` application name) for your own before running it.

## Verify the rollback

Open Service Fabric Explorer and check the main dashboard. Once the rollback completes you should see **Zero Application Upgrades in Progress**. If an upgrade is still listed, give it a moment and refresh — a rollback is itself an upgrade operation and takes time to drain across nodes.

