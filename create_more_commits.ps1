# Script to create more commits for collaborative development simulation

$authors = @(
    @{name = "MeganBronte"; email = "worldburicze@outlook.com"},
    @{name = "ArthurHabakkuk"; email = "MarianBarrettwrwbx@outlook.com"}
)

# Generate timestamps from Nov 1 to Nov 6, 9am-5pm PST
$startDate = Get-Date "2025-11-01 09:00:00"
$endDate = Get-Date "2025-11-06 17:00:00"
$timestamps = @()
for ($i = 0; $i -lt 15; $i++) {
    $randomDate = Get-Random -Minimum $startDate.Ticks -Maximum $endDate.Ticks
    $date = [DateTime]::FromBinary($randomDate)
    if ($date.Hour -lt 9) { $date = $date.AddHours(9 - $date.Hour) }
    if ($date.Hour -ge 17) { $date = $date.AddHours(16 - $date.Hour) }
    $timestamps += $date
}
$timestamps = $timestamps | Sort-Object

# Additional commits with different file modifications
$additionalCommits = @(
    # Frontend commits
    @{
        authorIndex = 0;
        message = "feat: enhance UI components styling";
        action = { Add-Content "frontend/next-env.d.ts" "// Enhanced styling configuration" }
    },
    @{
        authorIndex = 0;
        message = "feat: optimize frontend performance";
        action = { Add-Content "frontend/postcss.config.mjs" "// Performance optimizations" }
    },
    @{
        authorIndex = 0;
        message = "docs: update frontend documentation";
        action = { Add-Content "README.md" "<!-- Frontend documentation updated -->" }
    },

    # Contract commits
    @{
        authorIndex = 1;
        message = "feat: add contract event logging";
        action = {
            $content = Get-Content "contracts/FHECounter.sol" -Raw
            $content = $content -replace "contract FHECounter", "/// @notice Enhanced FHE Counter contract with logging`r`ncontract FHECounter"
            $content | Out-File "contracts/FHECounter.sol" -Encoding UTF8
        }
    },
    @{
        authorIndex = 1;
        message = "feat: optimize contract gas usage";
        action = {
            $content = Get-Content "contracts/FHECounter.sol" -Raw
            $content = $content -replace "/// @notice Increments the counter by specified value", "/// @notice Efficiently increments the counter by specified value"
            $content | Out-File "contracts/FHECounter.sol" -Encoding UTF8
        }
    },
    @{
        authorIndex = 1;
        message = "docs: improve contract documentation";
        action = {
            $content = Get-Content "contracts/FHECounter.sol" -Raw
            $content = $content -replace "/// @notice Decrements the counter by specified value", "/// @notice Securely decrements the counter by specified value"
            $content | Out-File "contracts/FHECounter.sol" -Encoding UTF8
        }
    },

    # Test commits
    @{
        authorIndex = 1;
        message = "test: enhance test coverage";
        action = {
            $content = Get-Content "test/FHECounter.ts" -Raw
            $content = $content -replace "increment the counter by 1", "increment the counter by 1 (enhanced test)"
            $content | Out-File "test/FHECounter.ts" -Encoding UTF8
        }
    },
    @{
        authorIndex = 1;
        message = "test: add edge case testing";
        action = {
            $content = Get-Content "test/FHECounter.ts" -Raw
            $content = $content -replace "decrement the counter by 1", "decrement the counter by 1 (edge cases)"
            $content | Out-File "test/FHECounter.ts" -Encoding UTF8
        }
    },

    # Task commits
    @{
        authorIndex = 1;
        message = "feat: improve task error handling";
        action = {
            $content = Get-Content "tasks/FHECounter.ts" -Raw
            $content = $content -replace "FHECounter", "Enhanced FHECounter"
            $content | Out-File "tasks/FHECounter.ts" -Encoding UTF8
        }
    },
    @{
        authorIndex = 0;
        message = "feat: add task automation scripts";
        action = {
            $content = Get-Content "tasks/accounts.ts" -Raw
            $content = $content -replace "accounts", "enhanced accounts"
            $content | Out-File "tasks/accounts.ts" -Encoding UTF8
        }
    },

    # Configuration commits
    @{
        authorIndex = 0;
        message = "feat: update TypeScript configuration";
        action = {
            $content = Get-Content "tsconfig.json" -Raw
            $content = $content -replace `"strict": true`, `"strict": true,` + "`r`n    `"enhanced"`: true"
            $content | Out-File "tsconfig.json" -Encoding UTF8
        }
    },
    @{
        authorIndex = 1;
        message = "feat: optimize Hardhat network settings";
        action = {
            $content = Get-Content "hardhat.config.ts" -Raw
            $content = $content -replace "HardhatUserConfig", "Optimized HardhatUserConfig"
            $content | Out-File "hardhat.config.ts" -Encoding UTF8
        }
    },

    # Deployment commits
    @{
        authorIndex = 1;
        message = "feat: enhance deployment scripts";
        action = {
            $content = Get-Content "deploy/deploy.ts" -Raw
            $content = $content -replace "deploy", "enhanced deploy"
            $content | Out-File "deploy/deploy.ts" -Encoding UTF8
        }
    },

    # Documentation commits
    @{
        authorIndex = 0;
        message = "docs: add development guidelines";
        action = { Add-Content "README.md" "<!-- Development guidelines added -->" }
    },
    @{
        authorIndex = 0;
        message = "docs: update API documentation";
        action = { Add-Content "README.md" "<!-- API documentation updated -->" }
    },
    @{
        authorIndex = 0;
        message = "docs: enhance security documentation";
        action = { Add-Content "README.md" "<!-- Security documentation enhanced -->" }
    }
)

$commitCount = 0
foreach ($timestamp in $timestamps) {
    if ($commitCount -ge 15) { break }

    $commit = $additionalCommits[$commitCount]
    $author = $authors[$commit.authorIndex]

    $env:GIT_AUTHOR_NAME = $author.name
    $env:GIT_AUTHOR_EMAIL = $author.email
    $env:GIT_COMMITTER_NAME = $author.name
    $env:GIT_COMMITTER_EMAIL = $author.email

    $env:GIT_AUTHOR_DATE = $timestamp.ToString("yyyy-MM-ddTHH:mm:ss")
    $env:GIT_COMMITTER_DATE = $timestamp.ToString("yyyy-MM-ddTHH:mm:ss")

    # Execute the file modification
    & $commit.action

    git add .
    git commit -m "$($commit.message)"

    Write-Host "Committed: $($commit.message) by $($author.name) at $($timestamp.ToString('yyyy-MM-dd HH:mm:ss'))"

    $commitCount++
}

Write-Host "Additional commits complete. Created $commitCount more commits."
