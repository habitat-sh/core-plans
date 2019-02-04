$pkg_name="shellcheck"
$hkg_name="ShellCheck"
$pkg_origin="core"
$pkg_version="0.6.0"
$pkg_license=@("GPL-3")
$pkg_upstream_url="http://www.shellcheck.net/"
$pkg_description="ShellCheck is a GPLv3 tool that gives warnings and suggestions for bash/sh shell scripts"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://hackage.haskell.org/package/${hkg_name}-${pkg_version}/${hkg_name}-${pkg_version}.tar.gz"
$pkg_shasum="f6e79fb34d076504176761cc8b7c3f996f8d31bed23250fb1570e32283cd7df6"
$pkg_dirname="${hkg_name}-${pkg_version}"


$pkg_bin_dirs=@("bin")

$pkg_build_deps=@(
  "core/7zip"
  "core/cabal-install"
  "core/ghc"
)

function Invoke-Unpack {
  Push-Location (Resolve-Path $HAB_CACHE_SRC_PATH).Path
  Try {
    $tar = $pkg_filename.Substring(0, $pkg_filename.LastIndexOf('.'))
    7z x -y (Resolve-Path $HAB_CACHE_SRC_PATH/$pkg_filename).Path
    7z x -y -o"." (Resolve-Path $HAB_CACHE_SRC_PATH/$tar).Path
  }
  Finally { Pop-Location }
}

function Invoke-Build {
  cabal v1-sandbox init
  cabal v1-update

  # Install dependencies
  cabal v1-install --only-dependencies

  # Configure and Build
  cabal v1-configure --prefix="$pkg_prefix" --disable-executable-dynamic --disable-shared
  cabal v1-build
}

function Invoke-Check {
  cabal v1-test
}

function Invoke-Install {
  cabal v1-copy
}
