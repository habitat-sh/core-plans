$pkg_name="dsc-core"
$pkg_origin="core"
$pkg_version="0.2.1"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Apache-2.0")
$pkg_description="Compiles and applies DSC configurations in Powershell Core"
$pkg_build_deps=@("core/ps-lock")

function Invoke-SetupEnvironment {
    Push-RuntimeEnv "PSModulePath" "\hab\pkgs\$pkg_origin\$pkg_name\$pkg_version\$pkg_release\Modules"
}

function Invoke-Install {
    mkdir "$pkg_prefix/Modules/DSCCore"
    Copy-Item "$PLAN_CONTEXT/DSCCore.psm1" "$pkg_prefix/Modules/DSCCore"
    Copy-Item "$PLAN_CONTEXT/DSCCore.psd1" "$pkg_prefix/Modules/DSCCore"
    Copy-Item "$(Get-HabPackagePath ps-lock)/Modules/PSLock/PSLock.psm1" "$pkg_prefix/Modules/DSCCore"
    Copy-Item "$(Get-HabPackagePath ps-lock)/Modules/PSLock/PSLock.psd1" "$pkg_prefix/Modules/DSCCore"
}
