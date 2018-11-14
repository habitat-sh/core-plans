$pkg_name="openssl"
$pkg_origin="core"
$pkg_version="1.0.2n"
$_pkg_version_text=($pkg_version).Replace(".", "_")
$pkg_description="OpenSSL is an open source project that provides a robust, commercial-grade, and full-featured toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols. It is also a general-purpose cryptography library."
$pkg_upstream_url="https://www.openssl.org"
$pkg_license=@("OpenSSL")
$pkg_source="https://github.com/openssl/openssl/archive/OpenSSL_$_pkg_version_text.zip"
$pkg_shasum="2afd08c5347b35d3ea3a8791fa0c22c0951180ed010f5db28a34b06175a9379b"
$pkg_build_deps=@("core/visual-cpp-build-tools-2015", "core/perl", "core/nasm")
$pkg_bin_dirs=@("bin")
$pkg_include_dirs=@("include")
$pkg_lib_dirs=@("lib")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    cd "$pkg_name-OpenSSL_$_pkg_version_text"
    perl Configure VC-WIN64A --prefix=$pkg_prefix
    ms\do_win64a
    nmake -f ms\ntdll.mak
    if($LASTEXITCODE -ne 0) { Write-Error "nmake failed!" }
}

function Invoke-Install {
    cd "$pkg_name-OpenSSL_$_pkg_version_text"
    ms\do_win64a
    nmake -f ms\ntdll.mak install
}
function Invoke-Check {
    cd "$pkg_name-OpenSSL_$_pkg_version_text"
    nmake -f ms\ntdll.mak test
}
