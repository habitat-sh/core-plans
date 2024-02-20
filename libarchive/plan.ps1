$pkg_name="libarchive"
$pkg_origin="core"
$pkg_version="3.7.2"
$pkg_description="Multi-format archive and compression library"
$pkg_upstream_url="https://www.libarchive.org"
$pkg_license=@("BSD")
$pkg_source="https://github.com/libarchive/libarchive/archive/refs/tags/v${pkg_version}.zip"
$pkg_shasum="d4d41a5f4839ce85f36c9e67b0f78db96e8732402db3f55881c8429b0c30f210"
$pkg_deps=@(
    "core/openssl",
    "core/bzip2",
    "core/xz",
    "core/zlib"
)
$pkg_build_deps=@("core/visual-cpp-build-tools-2015", "core/cmake")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    Set-Location "$pkg_name-$pkg_version"

    $bzip_lib = "$(Get-HabPackagePath bzip2)\lib\libbz2.lib"
    $bzip_includedir = "$(Get-HabPackagePath bzip2)\include"
    $zlib_libdir = "$(Get-HabPackagePath zlib)\lib\zlibwapi.lib"
    $zlib_includedir = "$(Get-HabPackagePath zlib)\include"
    $xz_libdir = "$(Get-HabPackagePath xz)\lib\liblzma.a"
    $xz_includedir = "$(Get-HabPackagePath xz)\include"

    cmake -G "Visual Studio 14 2015 Win64" -T "v140" -DCMAKE_SYSTEM_VERSION="8.1" -DCMAKE_INSTALL_PREFIX="${prefix_path}\libarchive" -DBZIP2_LIBRARY_RELEASE="${bzip_lib}" -DBZIP2_INCLUDE_DIR="${bzip_includedir}" -DZLIB_LIBRARY_RELEASE="${zlib_libdir}" -DZLIB_INCLUDE_DIR="${zlib_includedir}" -DLIBLZMA_INCLUDE_DIR="${xz_includedir}" -DLIBLZMA_LIBRARY="${xz_libdir}"
    msbuild /p:Configuration=Release /p:Platform=x64 "ALL_BUILD.vcxproj"
    if($LASTEXITCODE -ne 0) { Write-Error "msbuild failed!" }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\bin\Release\*.dll" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\$pkg_name\Release\*.lib" "$pkg_prefix\lib\" -Force
}
