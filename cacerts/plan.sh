pkg_name=cacerts
pkg_origin=core
pkg_description="\
The Mozilla CA certificate store in PEM format (around 250KB uncompressed).
"
pkg_upstream_url="https://curl.haxx.se/docs/caextract.html"
pkg_license=('MPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://curl.haxx.se/ca/cacert-2019-08-28.pem"
pkg_shasum="38b6230aa4bee062cd34ee0ff6da173250899642b1937fc130896290b6bd91e3"
pkg_deps=()
pkg_build_deps=()

pkg_version() {
  local build_date
  # Extract the build date of the certificates file
  # shellcheck disable=SC2002
  build_date="$(cat "$HAB_CACHE_SRC_PATH/$pkg_filename" \
    | grep 'Certificate data from Mozilla' \
    | sed 's/^## Certificate data from Mozilla as of: //')"

  # Update the `$pkg_version` value with the build date
  date --date="$build_date" "+%Y.%m.%d"
}

do_download() {
  do_default_download
  update_pkg_version
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
