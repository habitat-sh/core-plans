pkg_name=kmod
pkg_origin=core
pkg_version="29"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.1')
pkg_source="https://www.kernel.org/pub/linux/utils/kernel/${pkg_name}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="0b80eea7aa184ac6fd20cafa2a1fdf290ffecc70869a797079e2cc5c6225a52a"
pkg_deps=(core/glibc core/xz core/zlib)
pkg_build_deps=(core/make core/gcc core/pkg-config core/file core/sed core/diffutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="Linux kernel module management tools and library"
pkg_upstream_url="https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git"

do_before() {
  if [[ ! -f /usr/bin/file ]]; then
    hab pkg binlink core/file file -d /usr/bin
    _clean_file=true
  fi
}

do_build() {
  ./configure --prefix="${pkg_prefix}" --with-xz --with-zlib
  make
}

do_install() {
  do_default_install

  pushd "${pkg_prefix}/bin" >/dev/null
  for bin in {depmod,insmod,lsmod,modinfo,modprobe,rmmod}; do
    ln -s kmod "$bin"
  done
  popd >/dev/null
}

do_end() {
  if [[ -n "${_clean_file}" ]]; then
    rm -f /usr/bin/file
  fi
}
