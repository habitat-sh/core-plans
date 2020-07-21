$pkg_name="cacerts"
$pkg_origin="core"
$pkg_description="\
The Mozilla CA certificate store in PEM format (around 250KB uncompressed).
"
$pkg_upstream_url="https://curl.haxx.se/docs/caextract.html"
$pkg_version="2020.06.24"
$pkg_license=@('MPL-2.0')
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://curl.haxx.se/ca/cacert-2020-06-24.pem"
$pkg_shasum="726889705b00f736200ed7999f7a50021b8735d53228d679c4e6665aa3b44987"
function Invoke-Build { }

function Invoke-Unpack {
  mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Force
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Force
}

function Invoke-Install {
  mkdir "$pkg_prefix/ssl/certs"
  Copy-Item "$pkg_filename" "$pkg_prefix/ssl/certs/cacert.pem" -Force
  New-Item -ItemType SymbolicLink -Path "$pkg_prefix/ssl/" -Name "cert.pem" -Value "$pkg_prefix/ssl/certs/cacert.pem" -Force
}
