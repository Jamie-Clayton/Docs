gh auth login

$githubOwner = "jamie-clayton"
$githubTopic = "icecreamery"
$atlasianOwner = "dessert-ops"
$ticketbaseUrl = "https://$atlasianOwner.atlassian.net/browse" # Jira ticket base URL
$formattedDate = "{0:yyyy-MM-dd}" -f (Get-Date)
$atlasianProjectPrefixes = "FLAVOURS,SERVED"
# Get all repos with the topic
$repos = gh repo list $githubOwner  --topic $githubTopic --json name | ConvertFrom-Json

Clear-Host

foreach ($repo in $repos.Name) {
    # Remove existing autolinks
    $autolinks = gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/$githubOwner/$repo/autolinks | ConvertFrom-Json
    foreach ($autolink in $autolinks.id) {
        gh api --method DELETE -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/$githubOwner/$repo/autolinks/$autolink        
    }

    # Add autolinks
    Write-Host $repo
    foreach ($prefix in $atlasianProjectPrefixes.Split(',')) {
        # Create a autolink with numeric key prefix
        gh api --method POST -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" /repos/$githubOwner/$repo/autolinks -f "key_prefix=$prefix-" -f "url_template=$ticketbaseUrl/$prefix-<num>" -F "is_alphanumeric=false"
    }
}

# Report the results to the user
Clear-Host
$total = $repos.Count * $atlasianProjectPrefixes.Split(',').Count
Write-Host "$total autolinks created for $githubOwner/$githubTopic on $formattedDate"