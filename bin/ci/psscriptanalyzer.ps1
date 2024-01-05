param($plan)

$env:HAB_TEST_PLAN = $plan
$env:HAB_LICENSE = "accept-no-persist"

@('core/psscriptanalyzer', 'core/powershell') | ForEach-Object {
    $pkg = $_
    if (!(hab pkg list $pkg | Where-Object { $_.StartsWith($pkg) })) {
        hab pkg install $pkg
    }
}

& "$(hab pkg path core/powershell)\bin\pwsh" -WorkingDirectory $PSScriptRoot -Command {
    Import-Module "$(hab pkg path core/psscriptanalyzer)\module\PSScriptanAlyzer.psd1"

    $excludeAnalyzeScripts = @(
        'plan.ps1',
        'last_build.ps1',
        'pre_build.ps1'
    )
    $excludeFormatScripts = @(
        'last_build.ps1',
        'pre_build.ps1'
    )
    $planPath = Resolve-Path -Path "..\..\$env:HAB_TEST_PLAN"
    Write-Host "Linting $planPath :"

    Write-Host "Checking Powershell formatting..."
    # Excluding PSUseConsistentWhitespace because it conflicts with AlignAssignmentStatement and
    # PSUseConsistentIndentation which are higher value
    $formatErrors = Get-ChildItem $planPath\*.ps1 -Recurse -Exclude $excludeFormatScripts |
        Invoke-ScriptAnalyzer -Settings CodeFormattingOTBS -ExcludeRule PSUseConsistentWhitespace -Severity @('Error', 'Information', 'Warning')
    Write-Host ($formatErrors | Out-String)
    Write-Host "$($formatErrors.Count) errors found"

    Write-Host "Analyzing Powershell Scripts..."
    $analysisErrors = Get-ChildItem $planPath\*.ps1 -Recurse -Exclude $excludeAnalyzeScripts |
        Invoke-ScriptAnalyzer -Settings PSScriptAnalyzerSettingsForScripts.psd1 -Severity @('Error', 'Information', 'Warning') -ExcludeRule @('PSReviewUnusedParameter', 'ResourceNotDefined')
    Write-Host ($analysisErrors | Out-String)
    Write-Host "$($analysisErrors.Count) errors found"

    Write-Host "Analyzing Powershell Habitat plans..."
    $planErrors = Get-ChildItem $planPath\plan.ps1 -Recurse | Invoke-ScriptAnalyzer -Settings PSScriptAnalyzerSettingsForPlans.psd1
    Write-Host ($planErrors | Out-String)
    Write-Host "$($planErrors.Count) errors found"

    Exit $formatErrors.Count + $analysisErrors.Count + $planErrors.Count
}

Exit $LASTEXITCODE
