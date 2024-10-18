$pkg_name="perl"
$pkg_origin="core"
$pkg_version="5.41.2"
$pkg_description="Perl 5 is a highly capable, feature-rich programming language with over 29 years of development."
$pkg_upstream_url="http://www.perl.org/"
$pkg_license=@("GPL-1.0-or-later", "Artistic-1.0-Perl")
$pkg_source="https://github.com/Perl/perl5/archive/v$pkg_version.zip"
$pkg_shasum="263cdf14f32778f792d26fa341c34a22983115d5730521fb5fcb301a53614e0f"
$pkg_deps=@("core/visual-cpp-redist-2022")
$pkg_build_deps=@("core/visual-build-tools-2022", "core/windows-11-sdk")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-Build {
    $Env:CCTYPE = "MSVC143"
    $Env:VCTOOLSINSTALLDIR = "$(Get-HabPackagePath visual-build-tools-2022)\Contents\VC\Tools\MSVC\14.40.33807\"
    Set-Location perl5-$pkg_version\win32
    (Get-Content Makefile).Replace("`$(INST_DRV)\perl", $pkg_prefix) | Set-Content Makefile
    nmake
    if($LASTEXITCODE -ne 0) { Write-Error "nmake failed!" }
}

function Invoke-Install {
    $Env:CCTYPE = "MSVC143"
    $Env:VCTOOLSINSTALLDIR = "$(Get-HabPackagePath visual-build-tools-2022)\Contents\VC\Tools\MSVC\14.40.33807\"
    Set-Location perl5-$pkg_version\win32
    nmake install
    if($LASTEXITCODE -ne 0) { Write-Error "nmake failed!" }
}

function Invoke-Check {
    $Env:CCTYPE="MSVC143"
    $Env:VCTOOLSINSTALLDIR = "$(Get-HabPackagePath visual-build-tools-2022)\Contents\VC\Tools\MSVC\14.40.33807\"
    Set-Location perl5-$pkg_version\win32
    nmake test
}
