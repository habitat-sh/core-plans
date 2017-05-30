pkg_name=R
pkg_origin=core
pkg_version="3.4.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0+')
pkg_source="https://cran.r-project.org/src/base/R-3/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="288e9ed42457c47720780433b3d5c3c20983048b789291cc6a7baa11f9428b91"
pkg_upstream_url="https://www.r-project.org"
pkg_description="R is a free software environment for statistical computing and graphics."
pkg_build_deps=(
  core/coreutils
  core/texinfo
  core/diffutils
  core/file
  core/gcc
  core/icu
  core/libjpeg-turbo
  core/libpng
  core/libtiff
  core/make
  core/pkg-config
)
pkg_deps=(
  core/bzip2
  core/cairo
  core/curl
  core/harfbuzz
  core/icu
  core/libjpeg-turbo
  core/libpng
  core/libtiff
  core/pango
  core/pcre
  core/perl
  core/readline
  core/xz
  core/zlib
  core/gcc-libs
  core/glib
  core/expat
  core/pixman
  core/fontconfig
  core/freetype
)
pkg_bin_dirs=(lib64/R/bin)
pkg_include_dirs=(lib64/R/include)
pkg_lib_dirs=(lib64/R/lib)

do_build() {
    sed -i '/#include.*<cairo-xlib.h>/d' ./configure
    ./configure --prefix="${pkg_prefix}" \
		--with-x=no \
                --disable-java \
	        --enable-memory-profiling
    make
}

do_check() {
    make test
}
