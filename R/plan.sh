pkg_name=R
pkg_origin=core
pkg_version="3.4.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0+')
pkg_source="https://cran.r-project.org/src/base/R-3/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="971e30c2436cf645f58552905105d75788bd9733bddbcb7c4fbff4c1a6d80c64"
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
)
pkg_bin_dirs=(lib64/R/bin)
pkg_include_dirs=(lib64/R/include)
pkg_lib_dirs=(lib64/R/lib)

do_build() {
    sed -i'' '/#include.*<cairo-xlib.h>/d' ./configure
    ./configure --prefix="${pkg_prefix}" \
		 --with-x=no \
                --disable-java \
	         --enable-memory-profiling
    make
}

do_check() {
    make test
}
