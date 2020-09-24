$pkg_name="openssl-fips"
$pkg_origin="core"
$pkg_version="2.0.16"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_description="\
The OpenSSL FIPS Object Module v2.0 provide cryptographic services to \
external applications. The FIPS Object Module provides an API for invocation \
of FIPS approved cryptographic functions from calling applications, and is \
designed for use in conjunction with standard OpenSSL 1.0.1 and 1.0.2 \
distributions. \
"
$pkg_upstream_url="https://www.openssl.org"
$pkg_license=('OpenSSL')
$pkg_source="https://www.openssl.org/source/${pkg_name}-${pkg_version}.tar.gz"
$pkg_shasum="a3cd13d0521d22dd939063d3b4a0d4ce24494374b91408a05bdaca8b681c63d4"
$pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
$pkg_deps=@("core/visual-cpp-redist-2015")
$pkg_build_deps=@("core/visual-cpp-build-tools-2015", "core/perl", "core/nasm", "core/7zip")
$pkg_bin_dirs=@("bin")
$pkg_include_dirs=@("include")
$pkg_lib_dirs=@("lib")

function Invoke-Unpack {
  Push-Location (Resolve-Path $HAB_CACHE_SRC_PATH).Path
  Try {
      $tar = $pkg_filename.Substring(0, $pkg_filename.LastIndexOf('.'))
      7z x -y (Resolve-Path $HAB_CACHE_SRC_PATH/$pkg_filename).Path
      7z x -y -o"$pkg_dirname" (Resolve-Path $HAB_CACHE_SRC_PATH/$tar).Path
  } finally { Pop-Location }
}

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    Set-Location "$pkg_name-$pkg_version"
    perl Configure VC-WIN64A --prefix=$pkg_prefix
    ms\do_win64a
    nmake -f ms\ntdll.mak
    if($LASTEXITCODE -ne 0) { Write-Error "nmake failed!" }
}

function Invoke-Install {
    Set-Location "$pkg_name-$pkg_version"
    ms\do_win64a
    nmake -f ms\ntdll.mak install
}
function Invoke-Check {
    Set-Location "$pkg_name-$pkg_version"
    nmake -f ms\ntdll.mak test
}
