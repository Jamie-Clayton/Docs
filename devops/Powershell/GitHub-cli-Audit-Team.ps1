gh auth login

$githubOwner = "jamie-clayton"
$githubTeam = "dessert-lovers"
$formattedDate = Get-Date -Format "yyyy-MM-dd"
$sb = [System.Text.StringBuilder]::new()

Clear-Host

# Get all members of the team
$members = gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" "/orgs/$githubOwner/teams/$githubTeam/members"

# Check if members were found
if ($members.message -eq "Not Found") {
    Write-Host "No members found for $githubOwner/$githubTeam"
    return
}

# Save members to a JSON file
$members | Out-File -FilePath "$githubOwner-$githubTeam-members-$formattedDate.json" -Encoding utf8 -Force
Write-Host "Team details have been saved to $githubOwner-$githubTeam-members-$formattedDate.json"

# Convert members from a JSON object
$membersAsJson = $members | ConvertFrom-Json

# Iterate through each team member and get user details (and build a json file with all the user details)
$sb.Append("[")
foreach ($member in $membersAsJson) {
    $memberLogin = $member.login

    # Get user details for each member
    $user = gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2022-11-28" "/users/$memberLogin"

    # Append user details to the StringBuilder
    $sb.Append("$user,")
}
$sb.Append("]")

# Save user details to a JSON file
$sb.ToString() | Out-File -FilePath "$githubOwner-$githubTeam-users-$formattedDate.json" -Encoding utf8 -Force
Write-Host "User details have been saved to $githubOwner-$githubTeam-users-$formattedDate.json"

$teamUsers = $sb.ToString() | ConvertFrom-Json

# Check if any team user has not set a name in their GitHub profile (harder to find them in the GitHub web UI)
foreach ($teamUser in $teamUsers) {
    if ($null -eq $teamUser.name) {
        # In powershell how to inser a $teamUser property into string interpolation?
        Write-Host "User $($teamUser.login) has not set a name in their GitHub profile $($teamUser.html_url)"
    }
}