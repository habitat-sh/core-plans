pkg_name=R
pkg_origin=core
pkg_version="4.4.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later')
pkg_source="https://cran.r-project.org/src/base/R-4/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="0d93d224442dea253c2b086f088db6d0d3cfd9b592cd5496e8cb2143e90fc9e8"
pkg_upstream_url="https://www.r-project.org"
pkg_description="R is a free software environment for statistical computing and graphics."
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/file
  core/make
  core/perl
  core/pkg-config
  core/texinfo
)
pkg_deps=(
  core/bzip2
  core/cairo
  core/curl
  core/gcc
  core/harfbuzz
  core/icu
  core/expat
  core/fontconfig
  core/freetype
  core/glib
  core/libjpeg-turbo
  core/liberation-fonts-ttf
  core/libpng
  core/libtiff
  core/pango
  core/pcre
  core/pixman
  core/readline
  core/xz
  core/zlib
  core/which
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(lib/R/include)
pkg_lib_dirs=(lib/R/lib)

do_build() {
    sed -i '/#include.*<cairo-xlib.h>/d' ./configure
    ./configure --prefix="${pkg_prefix}" \
		 --with-x=no \
                --disable-java \
                --with-pcre1  \
	         --enable-memory-profiling
    make
}

do_check() {
    make test
}
