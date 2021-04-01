pkg_origin=core
pkg_name=numactl
pkg_version=2.0.14
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later' 'LGPL-2.1-or-later')
pkg_source=https://github.com/numactl/numactl/archive/v${pkg_version}.tar.gz
pkg_shasum=1ee27abd07ff6ba140aaf9bc6379b37825e54496e01d6f7343330cf1a4487035
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
