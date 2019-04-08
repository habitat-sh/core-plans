#!/usr/bin/env pwsh
param (
    [Parameter(Mandatory=$true)][string]$Skipbuild = 0
)

$__dir=(Get-Item $PSScriptRoot)
$PLAN_ROOT=(Get-Item $__dir ).parent.FullName

. $PLAN_ROOT/test/lib/habitat.ps1

if ($Skipbuild -eq 0) {
    habitat::build_git
}

habitat::load_git
habitat::test_git

