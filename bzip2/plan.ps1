$pkg_name="bzip2"
$pkg_origin="core"
$pkg_version="1.0.6"
$pkg_file_name=$pkg_name + ($pkg_version).Replace(".", "")
$pkg_description="bzip2 is a free and open-source file compression program that uses the Burrows–Wheeler algorithm. It only compresses single files and is not a file archiver."
$pkg_upstream_url="http://www.bzip.org/"
$pkg_license=("bzip2")
$pkg_source="https://github.com/nemequ/$pkg_name/archive/v${pkg_version}.zip"
$pkg_shasum="1ac730150d4c13a6933101c8d21acc6de258503ae8a6a049e948a47749ddcc81"
$pkg_build_deps=@("core/visual-cpp-build-tools-2015")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")
$pkg_include_dirs=@("include")

function Invoke-Build {
    cd "$pkg_name-$pkg_version"
    nmake -f makefile.msc
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\bzip2.exe" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\bzip2recover.exe" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\bzlib.h" "$pkg_prefix\include\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\libbz2.lib" "$pkg_prefix\lib\" -Force
}
