# PowerShell script to simulate collaborative commits
# Authors: MeganBronte (UI) and ArthurHabakkuk (Contract)
# Time range: Nov 1-6, 2025, 9am-5pm PST

$authors = @(
    @{name = "MeganBronte"; email = "worldburicze@outlook.com"},
    @{name = "ArthurHabakkuk"; email = "MarianBarrettwrwbx@outlook.com"}
)

$startDate = Get-Date "2025-11-01 09:00:00"
$endDate = Get-Date "2025-11-06 17:00:00"

# Generate 25 random timestamps within work hours (9am-5pm PST)
$timestamps = @()
for ($i = 0; $i -lt 25; $i++) {
    $randomDate = Get-Random -Minimum $startDate.Ticks -Maximum $endDate.Ticks
    $date = [DateTime]::FromBinary($randomDate)

    # Ensure it's within work hours
    if ($date.Hour -lt 9) { $date = $date.AddHours(9 - $date.Hour) }
    if ($date.Hour -ge 17) { $date = $date.AddHours(16 - $date.Hour) }

    $timestamps += $date
}

$timestamps = $timestamps | Sort-Object

# Conventional commit types and messages
$commitTypes = @("feat", "fix", "docs", "style", "refactor", "test", "chore")
$uiMessages = @(
    "feat: enhance UI responsiveness and layout",
    "fix: resolve button hover state issues",
    "docs: update component documentation",
    "style: improve code formatting and consistency",
    "refactor: optimize component rendering logic",
    "test: add unit tests for UI components",
    "chore: update dependencies and build scripts"
)

$contractMessages = @(
    "feat: implement new contract functionality",
    "fix: resolve gas optimization issues",
    "docs: update contract documentation",
    "style: improve code formatting and comments",
    "refactor: optimize contract logic",
    "test: add contract unit tests",
    "chore: update contract deployment scripts"
)

$currentAuthorIndex = 0
$commitCount = 0

foreach ($timestamp in $timestamps) {
    if ($commitCount -ge 20) { break }

    $author = $authors[$currentAuthorIndex]
    $env:GIT_AUTHOR_NAME = $author.name
    $env:GIT_AUTHOR_EMAIL = $author.email
    $env:GIT_COMMITTER_NAME = $author.name
    $env:GIT_COMMITTER_EMAIL = $author.email

    # Set the commit date
    $env:GIT_AUTHOR_DATE = $timestamp.ToString("yyyy-MM-ddTHH:mm:ss")
    $env:GIT_COMMITTER_DATE = $timestamp.ToString("yyyy-MM-ddTHH:mm:ss")

    # Choose appropriate message based on author role
    if ($author.name -eq "MeganBronte") {
        $message = $uiMessages | Get-Random
    } else {
        $message = $contractMessages | Get-Random
    }

    # Make a small file change to ensure actual content changes
    if ($author.name -eq "MeganBronte") {
        # UI changes - modify README or add comments to frontend files
        $readmePath = "README.md"
        $content = Get-Content $readmePath -Raw
        $content += "`n<!-- UI update $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') -->`n"
        $content | Out-File $readmePath -Encoding UTF8
    } else {
        # Contract changes - modify contract files or add comments
        $contractPath = "contracts/FHECounter.sol"
        $content = Get-Content $contractPath -Raw
        $content = $content -replace "/// @title A simple FHE counter contract", "/// @title A simple FHE counter contract`n/// @dev Updated $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        $content | Out-File $contractPath -Encoding UTF8
    }

    # Stage and commit
    git add .
    git commit -m "$message"

    Write-Host "Committed: $message by $($author.name) at $($timestamp.ToString('yyyy-MM-dd HH:mm:ss'))"

    # Switch to next author
    $currentAuthorIndex = 1 - $currentAuthorIndex
    $commitCount++
}

Write-Host "Simulation complete. Created $commitCount commits."
