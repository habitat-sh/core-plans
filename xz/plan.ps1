$pkg_name="xz"
$pkg_origin="core"
$pkg_version="5.2.5"
$pkg_description="XZ Utils is free general-purpose data compression software with a high compression ratio. XZ Utils were written for POSIX-like systems, but also work on some not-so-POSIX systems. XZ Utils are the successor to LZMA Utils."
$pkg_upstream_url="http://tukaani.org/xz/"
$pkg_license=@("GPL-2.0-or-later", "LGPL-2.0-or-later")
$pkg_source="https://tukaani.org/${pkg_name}/${pkg_name}-${pkg_version}-windows.zip"
$pkg_shasum="d83b82ca75dfab39a13dda364367b34970c781a9df4d41264db922ac3a8f622d"
$pkg_bin_dirs=@("bin")
$pkg_include_dirs=@("include")
$pkg_lib_dirs=@("lib")

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\bin_x86-64\*.dll" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\bin_x86-64\*.exe" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\bin_x86-64\*.a" "$pkg_prefix\lib\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\include\*" "$pkg_prefix\include\" -Recurse -Force
}
