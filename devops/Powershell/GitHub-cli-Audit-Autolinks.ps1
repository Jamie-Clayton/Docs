gh auth login

$githubOwner = "jamie-clayton"
$githubTopic = "icecreamery"
$formattedDate = "{0:yyyy-MM-dd}" -f (Get-Date)
$sb = [System.Text.StringBuilder]::new()

# Get all repos with the topic
$repos = gh repo list $githubOwner  --topic $githubTopic --json name | ConvertFrom-Json

$sb.Append("[")
foreach ($repo in $repos.Name) {
    $autolinks = gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/$githubOwner/$repo/autolinks
    $sb.Append("{ `"owner`": `"$githubOwner`",")
    $sb.Append("  `"topic`": `"$githubTopic`",")
    $sb.Append("  `"repo`": `"$repo`",")
    $sb.Append("  `"autolinkurl`": `"https://github.com/$githubOwner/$repo/settings/key_links`",")
    $sb.Append("  `"autolinks`": $autolinks")
    $sb.Append("},")
}
$sb.Append("]")
$sb.ToString() | Out-File -FilePath "$githubOwner-$githubTopic-autolinks-$formattedDate.json" -Encoding utf8 -Force

# Report the results to the user
Clear-Host
$found = $repos.Count
Write-Host "$found repos and the autolinks for $githubOwner/$githubTopic have been saved to $githubOwner-$githubTopic-autolinks-$formattedDate.json"