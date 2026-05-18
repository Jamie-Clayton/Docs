#requires -Version 7
<#
.SYNOPSIS
    One-shot migration: converts the legacy flat-structure documents (devops/, code/, SoftSkills/, root)
    into Chirpy _posts/ with proper YAML frontmatter, Diátaxis category mapping, topic tags, and
    redirect_from entries that preserve old GitHub-style URLs.

.DESCRIPTION
    For each entry in $Map this script:
      1. Reads the source markdown file
      2. Strips the original H1 (the new title comes from frontmatter)
      3. Strips the leading "**Document Type:**" annotation line (now expressed as categories)
      4. Rewrites internal cross-document links to the new /posts/... URLs
      5. Writes _posts/<date>-<slug>.md with full frontmatter

    Run from repo root. Re-running is safe — it overwrites _posts entries.

.NOTES
    Migration designed once, not a recurring tool. After verification, the originals are deleted.
#>
[CmdletBinding()]
param(
    [switch]$DeleteSources
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$RepoRoot = (Resolve-Path "$PSScriptRoot\..").Path
Push-Location $RepoRoot

# Map: source-path => @{ date; slug; categories=[type, group]; tags=[]; title }
$Map = @(
    @{ Path='Sustainability.md';                              Date='2021-01-10'; Slug='sustainability';                      Categories=@('Explanation','Engineering');   Tags=@('sustainability','green-software');             Title='Software Sustainability' }
    @{ Path='SoftSkills/Mindsets.md';                         Date='2026-05-16'; Slug='high-performance-mindsets';          Categories=@('Explanation','Soft Skills');   Tags=@('mindsets','performance','career');             Title='High-Performance Mindsets' }
    @{ Path='SoftSkills/Resilience.md';                       Date='2020-10-01'; Slug='building-resilience';                Categories=@('Explanation','Soft Skills');   Tags=@('resilience','career');                         Title='Building Resilience as a Software Engineer' }
    @{ Path='code/CQRS.md';                                   Date='2020-09-18'; Slug='cqrs';                               Categories=@('Explanation','Architecture');  Tags=@('cqrs','ddd','dotnet');                         Title='Command Query Responsibility Segregation (CQRS)' }
    @{ Path='code/CodeCoverage.md';                           Date='2020-11-20'; Slug='code-coverage';                      Categories=@('How-to','Testing');            Tags=@('testing','coverage','dotnet');                 Title='Code Coverage' }
    @{ Path='code/Licensing.md';                              Date='2020-09-22'; Slug='software-licensing';                 Categories=@('Explanation','Engineering');   Tags=@('licensing','intellectual-property','opensource'); Title='Software Licensing' }
    @{ Path='code/ProductionReady.md';                        Date='2020-08-24'; Slug='production-ready-software';          Categories=@('Explanation','Engineering');   Tags=@('production','reliability','quality');          Title='Production Ready Software' }
    @{ Path='code/RetiringAngularJs.md';                      Date='2020-04-05'; Slug='retiring-angularjs';                 Categories=@('How-to','Frontend');           Tags=@('angularjs','angular','migration');             Title='Retiring AngularJS: Migration Guide' }
    @{ Path='code/WebComponents.md';                          Date='2020-09-16'; Slug='web-components';                    Categories=@('Explanation','Frontend');      Tags=@('webcomponents','browser','frontend');          Title='Web Components' }
    @{ Path='devops/Architecture.md';                         Date='2020-08-24'; Slug='solution-architectures';            Categories=@('Explanation','Architecture');  Tags=@('architecture','solutions');                    Title='Solution Architectures' }
    @{ Path='devops/Automation.md';                           Date='2020-08-17'; Slug='powershell-automation';             Categories=@('Explanation','DevOps');        Tags=@('powershell','automation','windows');           Title='Automation with PowerShell' }
    @{ Path='devops/Aws-Cloud-Devops-Instructions.md';        Date='2023-09-11'; Slug='aws-cloud-devops';                  Categories=@('Tutorial','DevOps');           Tags=@('aws','cli','cdk','sam','cloud');               Title='AWS Cloud DevOps Setup' }
    @{ Path='devops/AzurePipelines.md';                       Date='2021-01-12'; Slug='azure-pipelines';                   Categories=@('Reference','DevOps');          Tags=@('azure','ci-cd','pipelines');                   Title='Azure Pipelines' }
    @{ Path='devops/Containers-Explanation.md';               Date='2026-05-16'; Slug='understanding-containers';          Categories=@('Explanation','DevOps');        Tags=@('docker','containers');                         Title='Understanding Containers for Local Development' }
    @{ Path='devops/Containers-HowTo.md';                     Date='2026-05-16'; Slug='containers-how-to';                 Categories=@('How-to','DevOps');             Tags=@('docker','containers');                         Title='Containers How-to Guides' }
    @{ Path='devops/Containers-Reference.md';                 Date='2026-05-16'; Slug='docker-cli-reference';              Categories=@('Reference','DevOps');          Tags=@('docker','cli');                                Title='Docker CLI Reference' }
    @{ Path='devops/Containers-ServiceFabric.md';             Date='2020-07-05'; Slug='containers-service-fabric';         Categories=@('Explanation','DevOps');        Tags=@('containers','service-fabric','azure');         Title='Containerization with Microsoft Service Fabric' }
    @{ Path='devops/Containers-Tutorial.md';                  Date='2026-05-16'; Slug='containers-redis-tutorial';         Categories=@('Tutorial','DevOps');           Tags=@('docker','redis','tutorial');                   Title='Your First Redis on Docker' }
    @{ Path='devops/ContinuosArchitecture.md';                Date='2023-10-08'; Slug='continuous-architecture';           Categories=@('Explanation','Architecture');  Tags=@('continuous-architecture');                     Title='Continuous Architecture' }
    @{ Path='devops/DesiredStateConfiguration.md';            Date='2020-08-17'; Slug='desired-state-configuration';       Categories=@('How-to','DevOps');             Tags=@('powershell','dsc','configuration');            Title='Desired State Configuration using PowerShell Core' }
    @{ Path='devops/GettingStarted-WindowsDevOps.md';         Date='2026-05-16'; Slug='getting-started-windows-devops';    Categories=@('Tutorial','DevOps');           Tags=@('windows','devops','getting-started');          Title='Getting Started: Windows DevOps Development' }
    @{ Path='devops/GitCommand.md';                           Date='2020-08-17'; Slug='git-command-reference';             Categories=@('Reference','DevOps');          Tags=@('git','versioning');                            Title='Git Command Reference' }
    @{ Path='devops/GitHub-cli.md';                           Date='2024-05-12'; Slug='github-cli-automation';             Categories=@('How-to','DevOps');             Tags=@('github','cli','automation');                   Title='Automating GitHub Tasks with the GitHub CLI' }
    @{ Path='devops/Microservices.md';                        Date='2021-04-21'; Slug='microservices-architecture';        Categories=@('Explanation','Architecture');  Tags=@('microservices','dotnet','architecture');       Title='Microservices Architecture (.NET/C#)' }
    @{ Path='devops/Npm.md';                                  Date='2020-07-06'; Slug='npm-cheat-sheet';                   Categories=@('Reference','DevOps');          Tags=@('npm','nodejs','javascript');                   Title='npm Cheat Sheet' }
    @{ Path='devops/PowerShell.md';                           Date='2020-08-17'; Slug='powershell-reference';              Categories=@('Reference','DevOps');          Tags=@('powershell','windows');                        Title='PowerShell Command Reference' }
    @{ Path='devops/nuget.md';                                Date='2021-12-05'; Slug='nuget-reference';                   Categories=@('Reference','DevOps');          Tags=@('nuget','dotnet','packages');                   Title='NuGet Package Automation' }
    @{ Path='devops/ssh.md';                                  Date='2020-03-31'; Slug='ssh-configuration-windows';         Categories=@('Tutorial','DevOps');           Tags=@('ssh','windows','security');                    Title='SSH Configuration on Windows' }
    @{ Path='devops/terraform.md';                            Date='2020-03-31'; Slug='terraform-on-windows';              Categories=@('Tutorial','DevOps');           Tags=@('terraform','iac','windows');                   Title='Terraform on Windows' }
)

# Index for fast lookup by (a) bare filename and (b) full path. Used during link rewriting.
$LinkIndex = @{}
foreach ($entry in $Map) {
    $year, $month, $day = $entry.Date -split '-'
    $newUrl = "/posts/$year/$month/$day/$($entry.Slug)/"
    $LinkIndex[$entry.Path.Replace('\','/')] = $newUrl
    $LinkIndex[(Split-Path $entry.Path -Leaf)] = $newUrl
}

function Format-YamlList {
    param([string[]]$Items)
    if (-not $Items -or $Items.Count -eq 0) { return '[]' }
    $quoted = $Items | ForEach-Object {
        if ($_ -match '[\s\-:]') { "'$($_ -replace "'", "''")'" } else { $_ }
    }
    return "[$($quoted -join ', ')]"
}

function ConvertTo-PostBody {
    param(
        [string]$Body,
        [hashtable]$LinkIndex
    )
    # Strip UTF-8 BOM if present (some legacy files have one and it breaks anchored regexes)
    $Body = $Body -replace "^﻿",''
    # Normalize CRLF for consistent processing
    $lines = $Body -split "`r?`n"
    $startIdx = 0

    # Skip leading blank lines so we can locate the H1 even when the file
    # begins with whitespace (some legacy docs start with a blank line).
    while ($startIdx -lt $lines.Count -and $lines[$startIdx] -match '^\s*$') {
        $startIdx++
    }
    if ($startIdx -lt $lines.Count -and $lines[$startIdx] -match '^\s*#\s+') {
        $startIdx++
    }

    # Skip blank lines and any leading blockquote lines that introduce the doc
    # (Document Type annotations, Diátaxis-quadrant headers, related-link banners).
    # Allow the bold marker to optionally contain a trailing colon (e.g. **Related:** vs **Related**).
    while ($startIdx -lt $lines.Count) {
        $line = $lines[$startIdx]
        if ($line -match '^\s*$') { $startIdx++; continue }
        if ($line -match '^\s*>\s*\*\*(Document Type|Tutorial|How-to|Reference|Explanation)[:\s]') { $startIdx++; continue }
        if ($line -match '^\s*>\s*\*\*(Related[^*]*|Prerequisites|You will build)[:]?\s*\*\*') { $startIdx++; continue }
        break
    }

    $trimmed = ($lines[$startIdx..($lines.Count-1)] -join "`n").TrimStart()

    # Rewrite internal links. Patterns to catch:
    #   ](path/file.md)
    #   ](./file.md)
    #   ](../folder/file.md)
    #   ](file.md)
    # Leave external (http) and anchor-only (#) links alone.
    $rewritten = [regex]::Replace($trimmed, '\]\(([^)\s]+\.md)(#[^)]*)?\)', {
        param($m)
        $rawLink = $m.Groups[1].Value
        $anchor = $m.Groups[2].Value
        if ($rawLink -match '^https?://') { return $m.Value }

        $key = $rawLink -replace '^\./',''
        $key = $key -replace '^\.\./',''
        $key = $key -replace '\\','/'

        $hit = $null
        if ($LinkIndex.ContainsKey($key)) { $hit = $LinkIndex[$key] }
        elseif ($LinkIndex.ContainsKey((Split-Path $key -Leaf))) { $hit = $LinkIndex[(Split-Path $key -Leaf)] }

        if ($hit) { return "]($hit$anchor)" }

        # Non-migrated repo-level docs (Contributing.md, README.md) -> GitHub source link
        $bareKey = (Split-Path $key -Leaf)
        if ($bareKey -in @('Contributing.md','README.md','LICENSE')) {
            return "](https://github.com/Jamie-Clayton/Docs/blob/master/$bareKey$anchor)"
        }
        return $m.Value
    })

    return $rewritten
}

# Ensure _posts exists
$postsDir = Join-Path $RepoRoot '_posts'
New-Item -ItemType Directory -Force -Path $postsDir | Out-Null

$unmatchedLinks = @()
$generated = 0

foreach ($entry in $Map) {
    $srcPath = Join-Path $RepoRoot $entry.Path
    if (-not (Test-Path $srcPath)) {
        Write-Warning "Source missing: $($entry.Path)"
        continue
    }

    $body = Get-Content -Path $srcPath -Raw -Encoding utf8
    $newBody = ConvertTo-PostBody -Body $body -LinkIndex $LinkIndex

    # Detect lingering .md links pointing into the legacy folders (catch-all)
    foreach ($leftover in [regex]::Matches($newBody, '\]\(([^)]+\.md)[^)]*\)')) {
        $link = $leftover.Groups[1].Value
        if ($link -notmatch '^https?://') {
            $unmatchedLinks += "  $($entry.Path) -> $link"
        }
    }

    $oldPath = $entry.Path.Replace('\','/')
    $redirects = @(
        "/$oldPath",
        "/$($oldPath -replace '\.md$','')",
        "/$($oldPath -replace '\.md$','').html"
    )

    # Quote title if it contains characters that confuse YAML parsers (: # ' " etc.)
    $titleYaml = if ($entry.Title -match '[:#''"]') {
        "'$($entry.Title -replace "'", "''")'"
    } else {
        $entry.Title
    }

    $frontmatter = @"
---
title: $titleYaml
date: $($entry.Date) 09:00:00 +1000
categories: $(Format-YamlList $entry.Categories)
tags: $(Format-YamlList $entry.Tags)
author: Jamie Clayton
redirect_from:
$(($redirects | ForEach-Object { "  - $_" }) -join "`n")
---

"@

    $outPath = Join-Path $postsDir ("$($entry.Date)-$($entry.Slug).md")
    Set-Content -Path $outPath -Value ($frontmatter + $newBody) -Encoding utf8
    $generated++
    Write-Host "  wrote $($entry.Date)-$($entry.Slug).md  <-  $($entry.Path)"
}

Write-Host ""
Write-Host "Generated $generated posts."

if ($unmatchedLinks.Count -gt 0) {
    Write-Host ""
    Write-Host "Unmatched .md links (will need manual review):" -ForegroundColor Yellow
    $unmatchedLinks | ForEach-Object { Write-Host $_ -ForegroundColor Yellow }
}

if ($DeleteSources) {
    Write-Host ""
    Write-Host "Deleting source files..." -ForegroundColor Cyan
    foreach ($entry in $Map) {
        $p = Join-Path $RepoRoot $entry.Path
        if (Test-Path $p) {
            git rm $p | Out-Null
            Write-Host "  removed $($entry.Path)"
        }
    }
    # Remove now-empty source directories
    foreach ($d in 'code','SoftSkills') {
        $dirPath = Join-Path $RepoRoot $d
        if ((Test-Path $dirPath) -and -not (Get-ChildItem $dirPath -Force)) {
            Remove-Item -Path $dirPath -Force
        }
    }
}

Pop-Location
