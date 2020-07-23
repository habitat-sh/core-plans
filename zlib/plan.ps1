$pkg_name="zlib"
$pkg_origin="core"
$pkg_version="1.2.11"
$pkg_file_name=$pkg_name + ($pkg_version).Replace(".", "")
$pkg_description="Compression library implementing the deflate compression method found in gzip and PKZIP."
$pkg_upstream_url="http://www.zlib.net/"
$pkg_license=("zlib")
$pkg_source="http://zlib.net/$pkg_file_name.zip"
$pkg_shasum="d7510a8ee1918b7d0cad197a089c0a2cd4d6df05fee22389f67f115e738b178d"
$pkg_build_deps=@("core/visual-cpp-build-tools-2015")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")
$pkg_include_dirs=@("include")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}
function Invoke-Build {
    Set-Location "$pkg_name-$pkg_version"
    msbuild /p:Configuration=Release /p:Platform=x64 "contrib\vstudio\vc14\zlibvc.sln"
    if($LASTEXITCODE -ne 0) { Write-Error "msbuild failed!" }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\contrib\vstudio\vc14\x64\ZlibDllRelease\zlibwapi.dll" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\contrib\vstudio\vc14\x64\ZlibDllRelease\zlibwapi.lib" "$pkg_prefix\lib\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\zlib.h" "$pkg_prefix\include\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\zconf.h" "$pkg_prefix\include\" -Force
}
