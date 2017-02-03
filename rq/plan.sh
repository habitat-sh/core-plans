pkg_name=rq
pkg_origin=core
pkg_version=0.9.2
pkg_source=https://github.com/dflemstr/rq/releases/download/v${pkg_version}/${pkg_name}-i686-unknown-linux-musl
pkg_shasum=01718bd4e52e5139d050dabbea308566a20c54d62a46fd28ab900819acc31c8b
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Some description."
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)

do_unpack() {
  return 0
}

do_prepare() {
  return 0
}

do_verify() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/bin
  install -v $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_prefix/bin/
}
