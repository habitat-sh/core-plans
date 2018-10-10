$pkg_name="xz"
$pkg_origin="core"
$pkg_version="5.2.3"
$pkg_description="XZ Utils is free general-purpose data compression software with a high compression ratio. XZ Utils were written for POSIX-like systems, but also work on some not-so-POSIX systems. XZ Utils are the successor to LZMA Utils."
$pkg_upstream_url="http://tukaani.org/xz/"
$pkg_license=@("gpl2+", "lgpl2+")
$pkg_source="https://tukaani.org/${pkg_name}/${pkg_name}-${pkg_version}-windows.zip"
$pkg_shasum="afe73c260e38fdebdd14c9eaab71c19b206ff74cebbdc744b0fa35b77b243220"
$pkg_bin_dirs=@("bin")
$pkg_include_dirs=@("include")
$pkg_lib_dirs=@("lib")

# function Invoke-Build {
#     cd "$pkg_name-$pkg_version"

    # $bzip_lib = "$(Get-HabPackagePath bzip2)\lib\libbz2.lib"
    # $bzip_includedir = "$(Get-HabPackagePath bzip2)\include"
    # $zlib_libdir = "$(Get-HabPackagePath zlib)\lib\zlibwapi.lib"
    # $zlib_includedir = "$(Get-HabPackagePath zlib)\include"

    # cmake -G "Visual Studio 14 2015 Win64" -T "v140" -DCMAKE_SYSTEM_VERSION="8.1" -DCMAKE_INSTALL_PREFIX="${prefix_path}\libarchive" -DBZIP2_LIBRARY_RELEASE="${bzip_lib}" -DBZIP2_INCLUDE_DIR="${bzip_includedir}" -DZLIB_LIBRARY_RELEASE="${zlib_libdir}" -DZLIB_INCLUDE_DIR="${zlib_includedir}"
    # msbuild /p:Configuration=Release /p:Platform=x64 "ALL_BUILD.vcxproj"
# }

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\bin_x86-64\*.dll" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\bin_x86-64\*.exe" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\bin_x86-64\*.a" "$pkg_prefix\lib\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\include\*" "$pkg_prefix\include\" -Recurse -Force

}
