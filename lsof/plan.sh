pkg_name="lsof"
pkg_origin="core"
pkg_version="4.91"
pkg_license=('lsof')
pkg_source="https://www.mirrorservice.org/sites/lsof.itap.purdue.edu/pub/tools/unix/lsof/lsof_${pkg_version}.tar.bz2"
pkg_shasum="c9da946a525fbf82ff80090b6d1879c38df090556f3fe0e6d782cb44172450a3"
pkg_upstream_url="https://people.freebsd.org/~abe/"
pkg_description="lsof - list open files"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_deps=(core/glibc)
pkg_bin_dirs=(bin)
pkg_build_deps=(core/coreutils core/make core/gcc core/busybox-static)
pkg_dirname="lsof_${pkg_version}"

do_unpack() {
  do_default_unpack
  $_tar_cmd xf "${CACHE_PATH}/${pkg_name}_${pkg_version}_src.tar" -C "${CACHE_PATH}" --strip-components=1
}

do_build() {
  export DESTDIR="$PREFIX"
  export LSOF_CFLAGS_OVERRIDE=1
  LSOF_INCLUDE="$(pkg_path_for glibc)/include/"
  export LSOF_INCLUDE
  pushd "$SRC_PATH" > /dev/null
  chmod +x ./Configure
  ./Configure linux -n
  make -j"$(nproc)"
  popd
}

do_install() {
  install -m 0755 "${SRC_PATH}/${pkg_name}" "${PREFIX}/bin"
}
