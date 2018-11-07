$pkg_name="dmake"
$pkg_origin="core"
$pkg_version="4.12.2.2"
$pkg_description="dmake"
$pkg_upstream_url="https://metacpan.org/release/dmake"
$pkg_license=@("gpl")
$pkg_source="https://cpan.metacpan.org/authors/id/S/SH/SHAY/dmake-$pkg_version.zip"
$pkg_shasum="c9dbffda19df70585cd4b83652085426f4dea874fd7480f2c4cb95d0b82f64c4"
$pkg_bin_dirs=@(".")

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_dirname\dmake\*" "$pkg_prefix" -Recurse -Force
}
