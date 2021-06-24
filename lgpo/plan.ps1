$pkg_name="lgpo"
$pkg_origin="core"
$pkg_version="3.0.2004.13001"
$pkg_maintainer=""
$pkg_license=@("Microsoft Software License")
$pkg_source="https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/LGPO.zip"
$pkg_shasum="CB7159D134A0A1E7B1ED2ADA9A3CE8CE8F4DE391D14403D55438AF824247CC55"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item "LGPO_30/LGPO.exe" "$pkg_prefix/bin" -Force
    Copy-Item "LGPO_30/LGPO.pdf" "$pkg_prefix/bin" -Force
}
