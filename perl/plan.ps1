$pkg_name="perl"
$pkg_origin="core"
$pkg_version="5.34.0"
$pkg_description="Perl 5 is a highly capable, feature-rich programming language with over 29 years of development."
$pkg_upstream_url="http://www.perl.org/"
$pkg_license=@("GPL-1.0-or-later", "Artistic-1.0-Perl")
$pkg_source="https://github.com/Perl/perl5/archive/v$pkg_version.zip"
$pkg_shasum="e46b8bd5be3c6dd13fdc2238928ecdff28db7f5cb8a409e239bb725e967159b5"
$pkg_deps=@("core/visual-cpp-redist-2015")
$pkg_build_deps=@("core/visual-cpp-build-tools-2015")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    $Env:CCTYPE   = "MSVC140"
    Set-Location perl5-$pkg_version\win32
    (Get-Content Makefile).Replace("`$(INST_DRV)\perl", $pkg_prefix) | Set-Content Makefile
    nmake
    if($LASTEXITCODE -ne 0) { Write-Error "nmake failed!" }
}

function Invoke-Install {
    $Env:CCTYPE   = "MSVC140"
    Set-Location perl5-$pkg_version\win32
    nmake install
    if($LASTEXITCODE -ne 0) { Write-Error "nmake failed!" }
}

function Invoke-Check {
    $Env:CCTYPE="MSVC140"
    Set-Location perl5-$pkg_version\win32
    nmake test
}
