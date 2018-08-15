$pkg_name="ps-lock"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Apache-2.0")
$pkg_description="Provides synchronization of scripts run in hooks that declare the same lock"

function Invoke-SetupEnvironment {
    Push-RuntimeEnv "PSModulePath" "\hab\pkgs\$pkg_origin\$pkg_name\$pkg_version\$pkg_release\Modules"
}

function Invoke-Install {
    mkdir "$pkg_prefix/Modules/PSLock"
    Copy-Item "$PLAN_CONTEXT/PSLock.psm1" "$pkg_prefix/Modules/PSLock"
    Copy-Item "$PLAN_CONTEXT/PSLock.psd1" "$pkg_prefix/Modules/PSLock"
}
