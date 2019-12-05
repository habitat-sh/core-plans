pkg_name=cacerts
pkg_origin=core
pkg_description="\
The Mozilla CA certificate store in PEM format (around 250KB uncompressed).
"
pkg_upstream_url="https://curl.haxx.se/docs/caextract.html"
pkg_version="2019.11.27"
pkg_license=('MPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://curl.haxx.se/ca/cacert-2019-11-27.pem"
pkg_shasum="0d98a1a961aab523c9dc547e315e1d79e887dea575426ff03567e455fc0b66b4"
pkg_deps=()
pkg_build_deps=()

do_download() {
  do_default_download
}

do_unpack() {
  mkdir -pv "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  cp -v "$HAB_CACHE_SRC_PATH/$pkg_filename" "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_build() {
  return 0
}

do_install() {
  mkdir -pv "$pkg_prefix/ssl/certs"
  cp -v "$pkg_filename" "$pkg_prefix/ssl/certs/cacert.pem"
  ln -sv certs/cacert.pem "$pkg_prefix/ssl/cert.pem"
}
