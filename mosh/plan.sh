pkg_name=mosh
pkg_origin=core
pkg_version=1.2.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('OCB-An-Authenticated-Encryption-Scheme')
pkg_description="Remote Terminal application that allows roaming, supports intermittent connectivity, and provides intelligent local echo and lines
editing of users keystrokes"
pkg_upstream_url=https://mosh.mit.edu
pkg_source=https://mosh.mit.edu/mosh-${pkg_version}.tar.gz
pkg_shasum=637adb7f67406447e9264d30468fe69a6d5e8f97518ef133d794cdc65483fa54
pkg_build_deps=(core/gcc core/make core/glibc)
pkg_deps=(core/glibc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
     ./configure
     make
     make install
 }


