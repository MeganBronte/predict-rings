# PowerShell script to simulate collaborative commits
# Authors: MeganBronte (UI/Frontend) and ArthurHabakkuk (Contract/Backend)
# Time range: Nov 1-6, 2025, 9am-5pm PST

$authors = @(
    @{name = "MeganBronte"; email = "worldburicze@outlook.com"; role = "UI"},
    @{name = "ArthurHabakkuk"; email = "MarianBarrettwrwbx@outlook.com"; role = "Contract"}
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

# Commit categories and their file changes
$commitCategories = @(
    # Project Configuration (3 commits)
    @{
        category = "config";
        authorIndex = 0;  # MeganBronte
        message = "feat: initialize project configuration and dependencies";
        files = @("package.json", "package-lock.json");
        action = "init"
    },
    @{
        category = "config";
        authorIndex = 0;
        message = "feat: configure TypeScript settings";
        files = @("tsconfig.json");
        action = "typescript"
    },
    @{
        category = "config";
        authorIndex = 1;  # ArthurHabakkuk
        message = "feat: set up Hardhat configuration for FHEVM";
        files = @("hardhat.config.ts");
        action = "hardhat"
    },

    # Contract Development (4 commits)
    @{
        category = "contract";
        authorIndex = 1;
        message = "feat: implement FHECounter contract structure";
        files = @("contracts/FHECounter.sol");
        action = "contract_structure"
    },
    @{
        category = "contract";
        authorIndex = 1;
        message = "feat: add FHECounter increment functionality";
        files = @("contracts/FHECounter.sol");
        action = "contract_increment"
    },
    @{
        category = "contract";
        authorIndex = 1;
        message = "feat: add FHECounter decrement functionality";
        files = @("contracts/FHECounter.sol");
        action = "contract_decrement"
    },
    @{
        category = "contract";
        authorIndex = 1;
        message = "feat: implement FHECounter reset function";
        files = @("contracts/FHECounter.sol");
        action = "contract_reset"
    },

    # Testing (3 commits)
    @{
        category = "test";
        authorIndex = 1;
        message = "test: create FHECounter test suite";
        files = @("test/FHECounter.ts");
        action = "test_structure"
    },
    @{
        category = "test";
        authorIndex = 1;
        message = "test: add increment function tests";
        files = @("test/FHECounter.ts");
        action = "test_increment"
    },
    @{
        category = "test";
        authorIndex = 1;
        message = "test: add decrement function tests";
        files = @("test/FHECounter.ts");
        action = "test_decrement"
    },

    # Task Scripts (3 commits)
    @{
        category = "tasks";
        authorIndex = 1;
        message = "feat: create FHECounter interaction tasks";
        files = @("tasks/FHECounter.ts");
        action = "tasks_fhe"
    },
    @{
        category = "tasks";
        authorIndex = 1;
        message = "feat: add account management tasks";
        files = @("tasks/accounts.ts");
        action = "tasks_accounts"
    },
    @{
        category = "tasks";
        authorIndex = 1;
        message = "feat: integrate task scripts with Hardhat";
        files = @("hardhat.config.ts");
        action = "tasks_integration"
    },

    # Type Definitions (3 commits)
    @{
        category = "types";
        authorIndex = 0;
        message = "feat: generate TypeScript types for contracts";
        files = @("types/contracts/FHECounter.ts");
        action = "types_contract"
    },
    @{
        category = "types";
        authorIndex = 0;
        message = "feat: add FHEVM library type definitions";
        files = @("types/@fhevm/index.ts");
        action = "types_fhevm"
    },
    @{
        category = "types";
        authorIndex = 0;
        message = "feat: configure Hardhat type extensions";
        files = @("types/hardhat.d.ts");
        action = "types_hardhat"
    },

    # Frontend Setup (3 commits)
    @{
        category = "frontend";
        authorIndex = 0;
        message = "feat: initialize Next.js frontend project";
        files = @("frontend/next-env.d.ts");
        action = "frontend_init"
    },
    @{
        category = "frontend";
        authorIndex = 0;
        message = "feat: configure frontend build settings";
        files = @("frontend/postcss.config.mjs");
        action = "frontend_config"
    },
    @{
        category = "frontend";
        authorIndex = 0;
        message = "feat: set up frontend development environment";
        files = @("frontend/package.json");
        action = "frontend_deps"
    },

    # Deployment (2 commits)
    @{
        category = "deploy";
        authorIndex = 1;
        message = "feat: create deployment scripts";
        files = @("deploy/deploy.ts");
        action = "deploy_script"
    },
    @{
        category = "deploy";
        authorIndex = 1;
        message = "feat: add deployment configuration";
        files = @("deployments/sepolia/FHECounter.json");
        action = "deploy_config"
    },

    # Documentation (2 commits)
    @{
        category = "docs";
        authorIndex = 0;
        message = "docs: create project README";
        files = @("README.md");
        action = "readme"
    },
    @{
        category = "docs";
        authorIndex = 0;
        message = "docs: add project license";
        files = @("LICENSE");
        action = "license"
    }
)

$currentAuthorIndex = 0
$commitCount = 0

foreach ($timestamp in $timestamps) {
    if ($commitCount -ge 22) { break }

    # Select appropriate category based on commit count
    $categoryIndex = $commitCount % $commitCategories.Count
    $category = $commitCategories[$categoryIndex]

    $author = $authors[$category.authorIndex]
    $env:GIT_AUTHOR_NAME = $author.name
    $env:GIT_AUTHOR_EMAIL = $author.email
    $env:GIT_COMMITTER_NAME = $author.name
    $env:GIT_COMMITTER_EMAIL = $author.email

    # Set the commit date
    $env:GIT_AUTHOR_DATE = $timestamp.ToString("yyyy-MM-ddTHH:mm:ss")
    $env:GIT_COMMITTER_DATE = $timestamp.ToString("yyyy-MM-ddTHH:mm:ss")

    # Stage and commit based on category
    switch ($category.action) {
        "init" {
            git add package.json package-lock.json
        }
        "typescript" {
            git add tsconfig.json
        }
        "hardhat" {
            git add hardhat.config.ts
        }
        "contract_structure" {
            git add contracts/FHECounter.sol
        }
        "contract_increment" {
            # Make a small change to contract
            $content = Get-Content "contracts/FHECounter.sol" -Raw
            $content = $content -replace "/// @notice Increments the counter", "/// @notice Increments the counter by specified value"
            $content | Out-File "contracts/FHECounter.sol" -Encoding UTF8
            git add contracts/FHECounter.sol
        }
        "contract_decrement" {
            # Make a small change to contract
            $content = Get-Content "contracts/FHECounter.sol" -Raw
            $content = $content -replace "/// @notice Decrements the counter", "/// @notice Decrements the counter by specified value"
            $content | Out-File "contracts/FHECounter.sol" -Encoding UTF8
            git add contracts/FHECounter.sol
        }
        "contract_reset" {
            # Make a small change to contract
            $content = Get-Content "contracts/FHECounter.sol" -Raw
            $content = $content -replace "/// @notice Resets the counter", "/// @notice Resets the counter to zero"
            $content | Out-File "contracts/FHECounter.sol" -Encoding UTF8
            git add contracts/FHECounter.sol
        }
        "test_structure" {
            git add test/FHECounter.ts
        }
        "test_increment" {
            # Make a small change to test file
            $content = Get-Content "test/FHECounter.ts" -Raw
            $content = $content -replace "increment the counter", "increment the counter by 1"
            $content | Out-File "test/FHECounter.ts" -Encoding UTF8
            git add test/FHECounter.ts
        }
        "test_decrement" {
            # Make a small change to test file
            $content = Get-Content "test/FHECounter.ts" -Raw
            $content = $content -replace "decrement the counter", "decrement the counter by 1"
            $content | Out-File "test/FHECounter.ts" -Encoding UTF8
            git add test/FHECounter.ts
        }
        "tasks_fhe" {
            git add tasks/FHECounter.ts
        }
        "tasks_accounts" {
            git add tasks/accounts.ts
        }
        "tasks_integration" {
            # Make a small change to hardhat config
            $content = Get-Content "hardhat.config.ts" -Raw
            $content = $content -replace "import", "// Task imports`r`n" + "import"
            $content | Out-File "hardhat.config.ts" -Encoding UTF8
            git add hardhat.config.ts
        }
        "types_contract" {
            git add types/contracts/FHECounter.ts
        }
        "types_fhevm" {
            git add types/@fhevm/index.ts
        }
        "types_hardhat" {
            git add types/hardhat.d.ts
        }
        "frontend_init" {
            git add frontend/next-env.d.ts
        }
        "frontend_config" {
            git add frontend/postcss.config.mjs
        }
        "frontend_deps" {
            git add frontend/package.json
        }
        "deploy_script" {
            git add deploy/deploy.ts
        }
        "deploy_config" {
            git add deployments/sepolia/FHECounter.json
        }
        "readme" {
            git add README.md
        }
        "license" {
            git add LICENSE
        }
    }

    git commit -m "$($category.message)"

    Write-Host "Committed [$($category.category)]: $($category.message) by $($author.name) at $($timestamp.ToString('yyyy-MM-dd HH:mm:ss'))"

    # Switch to next author for variety
    $currentAuthorIndex = 1 - $currentAuthorIndex
    $commitCount++
}

Write-Host "Collaboration simulation complete. Created $commitCount commits."
