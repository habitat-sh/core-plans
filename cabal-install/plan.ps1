$pkg_name="cabal-install"
$pkg_origin="core"
$pkg_version="2.4.1.0"
$pkg_license=@("BSD-3-Clause")
$pkg_upstream_url="https://www.haskell.org/cabal/"
$pkg_description="Command-line interface for Cabal and Hackage"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://downloads.haskell.org/~cabal/cabal-install-latest/cabal-install-${pkg_version}-x86_64-unknown-mingw32.zip"
$pkg_shasum="95f233efedb1ebf0e6db015fa2f55c1ed00b9938d207ec63c066f706fb4b6373"

$pkg_bin_dirs=@("bin")

$pkg_build_deps=@(
  "core/ghc"
)

function Invoke-Check {
  ./cabal.exe v1-update
  ./cabal.exe info cabal
}

function Invoke-Install {
  Copy-Item "cabal.exe" "$pkg_prefix/bin/" -Force
}
