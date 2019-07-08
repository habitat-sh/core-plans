# Ensure plan name has been passed
param (
    [Parameter()]
    [string]$Plan = $(throw "Usage: powershell-linting.ps1 [plan] e.g. powershell-linting.ps1 7zip")
)

$ErrorActionPreference = "Stop"

# Ensure PSScriptAnalyzer is installed
if (-Not (Get-Module -ListAvailable -Name PSScriptAnalyzer)) {
  # TODO: PSScriptAnalyzer should have its own core plan
  Install-PackageProvider Nuget -MinimumVersion 2.8.5.201 -Force
  Install-Module -Name PSScriptAnalyzer -Force
}

$issues = Invoke-ScriptAnalyzer -Path $Plan -Recurse -Setting .\bin\ci\PSScriptAnalyzerSettings.psd1
if ($issues) {
  Write-Host "Issues found with "$Plan":"
  Write-Host ($issues | Out-String)
  exit 1
}