pkg_origin=core
pkg_name=numactl
pkg_version=2.0.12
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later' 'LGPL-2.1-or-later')
pkg_source=https://github.com/numactl/numactl/archive/v${pkg_version}.tar.gz
pkg_shasum=7c3e819c2bdeb883de68bafe88776a01356f7ef565e75ba866c4b49a087c6bdf
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/autoconf core/automake core/libtool)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/numactl/numactl
pkg_description="NUMA support for Linux http://oss.sgi.com/projects/libnuma/"

do_prepare() {
  ACLOCAL_PATH="$ACLOCAL_PATH:$(pkg_path_for core/libtool)/share/aclocal"
  export ACLOCAL_PATH

  autoreconf -vfi
}

# Running make check will reconfigure your systems NUMA settings until you
# issue a reboot. This is _probably_ behavior you do not want! Do not uncomment
# this unless you intend to reboot immediately after this build.
# do_check() {
#   make check
# }
