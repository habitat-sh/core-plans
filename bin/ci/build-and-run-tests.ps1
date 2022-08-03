param($plan)

$env:HAB_ORIGIN = "ci"
$env:HAB_LICENSE = "accept-no-persist"

Set-Location "$PSScriptRoot\..\..\"

hab origin key generate $env:HAB_ORIGIN
hab pkg build $plan

. /results/last_build.ps1

if(Test-Path "$plan\tests\test.ps1") {
    hab studio run "$plan\tests\test.ps1 $pkg_ident; exit `$LASTEXITCODE"
} else {
    Write-Warning "$plan has no Windows tests to run. This is currently permitted but please consider adding some tests."
}

Exit $LASTEXITCODE
