$pkg_name="cabal-install"
$pkg_origin="core"
$pkg_version="3.6.2.0"
$pkg_license=@("BSD-3-Clause")
$pkg_upstream_url="https://www.haskell.org/cabal/"
$pkg_description="Command-line interface for Cabal and Hackage"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://downloads.haskell.org/~cabal/cabal-install-latest/cabal-install-${pkg_version}-x86_64-windows.zip"
$pkg_shasum="89aa3aa3f76d15182c0d03227639890cd537627ba0bf0ef9ab451fee504b24c6"

$pkg_bin_dirs=@("bin")

$pkg_build_deps=@(
    "core/ghc86"
)

function Invoke-Check {
    ./cabal.exe v1-update
    ./cabal.exe info cabal
}

function Invoke-Install {
    Copy-Item "cabal.exe" "$pkg_prefix/bin/" -Force
}
