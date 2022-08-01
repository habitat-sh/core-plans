pkg_name=libedit
pkg_origin=core
pkg_version=20210910-3.1
pkg_license=('BSD-3-Clause')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://thrysoee.dk/editline/${pkg_name}-${pkg_version}.tar.gz
pkg_upstream_url="https://thrysoee.dk/editline/"
pkg_description="This is an autotool- and libtoolized port of the NetBSD Editline library (libedit)."
pkg_shasum=6792a6a992050762edcca28ff3318cdb7de37dccf7bc30db59fcd7017eed13c5
pkg_deps=(core/glibc core/ncurses)
pkg_build_deps=(core/gcc core/make core/coreutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  ./configure --enable-widec --prefix="$pkg_prefix"
}
