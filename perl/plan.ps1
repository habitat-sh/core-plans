$pkg_name="perl"
$pkg_origin="core"
$pkg_version="5.28.1"
$pkg_description="Perl 5 is a highly capable, feature-rich programming language with over 29 years of development."
$pkg_upstream_url="http://www.perl.org/"
$pkg_license=@("gpl", "perlartistic")
$pkg_source="https://github.com/Perl/perl5/archive/v$pkg_version.zip"
$pkg_shasum="d7d2f2391022261cc7752f3f18af9def7f867ea061858a9a6ba70e56c2d32211"
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
