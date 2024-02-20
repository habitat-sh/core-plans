$pkg_name="openssl"
$pkg_origin="core"
$pkg_version="1.1.1w"
$_pkg_version_text=($pkg_version).Replace(".", "_")
$pkg_description="OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. It is also a general-purpose cryptography library."
$pkg_upstream_url="https://www.openssl.org"
$pkg_license=@("OpenSSL")
$pkg_source="https://github.com/openssl/openssl/archive/OpenSSL_$_pkg_version_text.zip"
$pkg_shasum="c543d84c06e909bfa862d5256f6d9dad502352a580b1193ae262874e4be4d7f7"
$pkg_deps=@("core/visual-cpp-redist-2015")
$pkg_build_deps=@("core/visual-cpp-build-tools-2015", "core/perl", "core/nasm")
$pkg_bin_dirs=@("bin")
$pkg_include_dirs=@("include")
$pkg_lib_dirs=@("lib")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    Set-Location "$pkg_name-OpenSSL_$_pkg_version_text"
    perl Configure VC-WIN64A --prefix=$pkg_prefix --openssldir=$pkg_prefix\SSL
    nmake
    if($LASTEXITCODE -ne 0) { Write-Error "nmake failed!" }
}

function Invoke-Install {
    Set-Location "$pkg_name-OpenSSL_$_pkg_version_text"
    nmake install
}
function Invoke-Check {
    Set-Location "$pkg_name-OpenSSL_$_pkg_version_text"
    nmake test
}
