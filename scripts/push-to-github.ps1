# Run from repo root after GitHub login:
#   cd c:\Users\YachitGuliani\Desktop\snowflake-dbt
#   .\scripts\push-to-github.ps1
#
# Optional: set org (default = your personal account)
#   $env:GITHUB_ORG = "GrowthArc"
#   .\scripts\push-to-github.ps1

$ErrorActionPreference = "Stop"
$RepoName = "growtharc-finance-mvp-dbt"
$Description = "Medallion dbt on Snowflake for GrowthArc Finance MVP — staging, gold marts, Semantic Layer, dbt Cloud + Cursor MCP."

Remove-Item Env:GITHUB_TOKEN -ErrorAction SilentlyContinue

$gh = Get-Command gh -ErrorAction SilentlyContinue
if (-not $gh) {
    Write-Host "Install GitHub CLI: winget install GitHub.cli"
    exit 1
}

gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Opening GitHub login in browser..."
    gh auth login -h github.com -p https -w
}

$login = gh api user -q .login
$org = $env:GITHUB_ORG

if ($org) {
    $fullName = "$org/$RepoName"
    Write-Host "Creating repo under org: $fullName"
    gh repo create $fullName --private --description $Description --source . --remote origin --push
} else {
    $fullName = "$login/$RepoName"
    Write-Host "Creating repo under user: $fullName"
    gh repo create $RepoName --private --description $Description --source . --remote origin --push
}

Write-Host "Done: https://github.com/$fullName"
