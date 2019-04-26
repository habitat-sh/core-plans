pkg_name=libiconv
pkg_version=1.14
pkg_origin=core
pkg_license=('GPL-3.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://ftp.gnu.org/pub/gnu/"${pkg_name}"/"${pkg_name}"-"${pkg_version}".tar.gz
pkg_upstream_url="https://www.gnu.org/software/libiconv/"
pkg_description="Some programs, like mailers and web browsers, must be able to convert \
between a given text encoding and the user's encoding.  Other programs \
internally store strings in Unicode, to facilitate internal processing, \
and need to convert between internal string representation (Unicode) \
and external string representation (a traditional encoding) when they \
are doing I/O.  GNU libiconv is a conversion library for both kinds of \
applications."
pkg_filename="${pkg_name}"-"${pkg_version}".tar.gz
pkg_shasum=72b24ded17d687193c3366d0ebe7cde1e6b18f0df8c55438ac95be39e8a30613
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
    patch -p1 -i "$PLAN_CONTEXT"/patches/libiconv-1.14_srclib_stdio.in.h-remove-gets-declarations.patch
    ./configure --prefix="${pkg_prefix}"
    make
}
