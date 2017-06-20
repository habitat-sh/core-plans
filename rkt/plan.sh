pkg_name=rkt
pkg_description="rkt - the pod native container engine"
pkg_origin=core
pkg_version=1.26.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://github.com/rkt/rkt/releases/download/v${pkg_version}/rkt-v${pkg_version}.tar.gz
pkg_upstream_url=https://github.com/rkt/rkt/releases
pkg_shasum=3123be2f4ea5221c92ab342edfb02aa2c07cb65144ea29eb202687f454f95e9d
pkg_dirname=rkt-v${pkg_version}
pkg_deps=(core/gnupg core/glibc)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  install -v -D "rkt" "$pkg_prefix/bin/rkt"
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
           --set-rpath "$LD_RUN_PATH" \
           "$pkg_prefix/bin/rkt"

}

do_strip() {
  return 0
}
