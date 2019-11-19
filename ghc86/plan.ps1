. "..\ghc\plan.ps1"

$pkg_name="ghc86"
$pkg_origin="core"
$pkg_version="8.6.5"
$pkg_license=@("BSD-3-Clause")
$pkg_upstream_url="https://www.haskell.org/ghc/"
$pkg_description="The Glasgow Haskell Compiler"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://downloads.haskell.org/~ghc/${pkg_version}/ghc-${pkg_version}-x86_64-unknown-mingw32.tar.xz"
$pkg_shasum="457024c6ea43bdce340af428d86319931f267089398b859b00efdfe2fd4ce93f"
$pkg_dirname="ghc-${pkg_version}"

$pkg_include_dirs=@("lib/ghc-${pkg_version}/include")
