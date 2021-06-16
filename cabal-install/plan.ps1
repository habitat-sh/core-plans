$pkg_name="cabal-install"
$pkg_origin="core"
$pkg_version="3.4.0.0"
$pkg_license=@("BSD-3-Clause")
$pkg_upstream_url="https://www.haskell.org/cabal/"
$pkg_description="Command-line interface for Cabal and Hackage"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://downloads.haskell.org/~cabal/cabal-install-latest/cabal-install-${pkg_version}-x86_64-windows.zip"
$pkg_shasum="860fff2d39a82d1dc0ca924a77164d0988af49c2c5f45e15d615144122beb647"

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
