param($plan)

$env:HAB_ORIGIN = "ci"
$env:HAB_LICENSE = "accept-no-persist"
$env:DO_CHECK = "true"

Set-Location "$PSScriptRoot\..\..\"

hab origin key generate $env:HAB_ORIGIN
hab pkg build $plan

exit $LASTEXITCODE