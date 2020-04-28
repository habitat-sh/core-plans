$pkg_name="bzip2"
$pkg_origin="core"
$pkg_version="1.0.8"
$pkg_file_name=$pkg_name + ($pkg_version).Replace(".", "")
$pkg_description="bzip2 is a free and open-source file compression program that uses the Burrows-Wheeler algorithm. It only compresses single files and is not a file archiver."
$pkg_upstream_url="http://www.bzip.org/"
$pkg_license=("bzip2")
$pkg_source="https://fossies.org/linux/misc/${pkg_name}-${pkg_version}.zip"
$pkg_shasum="7585f461a58476bb2697642b5bd4e6fb173404a5e59ae8cd557226b0fd388405"
$pkg_deps=@("core/visual-cpp-redist-2015")
$pkg_build_deps=@("core/visual-cpp-build-tools-2015")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")
$pkg_include_dirs=@("include")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}
function Invoke-Build {
    Set-Location "$pkg_name-$pkg_version"
    nmake -f makefile.msc
    if($LASTEXITCODE -ne 0) { Write-Error "nmake failed!" }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\bzip2.exe" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\bzip2recover.exe" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\bzlib.h" "$pkg_prefix\include\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\libbz2.lib" "$pkg_prefix\lib\" -Force
}
