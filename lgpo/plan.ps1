$pkg_name="lgpo"
$pkg_origin="core"
$pkg_version="2.2"
$pkg_maintainer=""
$pkg_license=@("Microsoft Software License")
$pkg_source="https://download.microsoft.com/download/8/5/C/85C25433-A1B0-4FFA-9429-7E023E7DA8D8/LGPO.zip"
$pkg_shasum="6FFB6416366652993C992280E29FAEA3507B5B5AA661C33BA1AF31F48ACEA9C4"
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/LGPO.zip" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item LGPO.exe "$pkg_prefix/bin" -Force
  Copy-Item LGPO.pdf "$pkg_prefix/bin" -Force
}
