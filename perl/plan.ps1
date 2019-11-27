$pkg_name="perl"
$pkg_origin="core"
$pkg_version="5.30.0"
$pkg_description="Perl 5 is a highly capable, feature-rich programming language with over 29 years of development."
$pkg_upstream_url="http://www.perl.org/"
$pkg_license=@("GPL-1.0-or-later", "Artistic-1.0-Perl")
$pkg_source="https://github.com/Perl/perl5/archive/v$pkg_version.zip"
$pkg_shasum="2b3747deadea0510ef9e567e6a8b692e7dd4ecad024f1a5a6108b971093a95fd"
$pkg_deps=@("core/visual-cpp-redist-2015")
$pkg_build_deps=@("core/visual-cpp-build-tools-2015", "core/dmake")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    $Env:CCTYPE="MSVC140"
    $Env:INST_TOP="$pkg_prefix"
    cd perl5-$pkg_version\win32
    dmake
    if($LASTEXITCODE -ne 0) { Write-Error "dmake failed!" }
}

function Invoke-Install {
    $Env:CCTYPE="MSVC140"
    $Env:INST_TOP="$pkg_prefix"
    cd perl5-$pkg_version\win32
    dmake install
    if($LASTEXITCODE -ne 0) { Write-Error "dmake failed!" }
}

function Invoke-Check {
    $Env:CCTYPE="MSVC140"
    cd perl5-$pkg_version\win32
    dmake test
}
