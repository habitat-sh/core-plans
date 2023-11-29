pkg_name=expat
pkg_origin=core
pkg_version=2.4.6
_dl_version="R_2_4_6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Expat is a stream-oriented XML parser library written in C. Expat excels with \
files too large to fit RAM, and where performance and flexibility are crucial.\
"
pkg_upstream_url="https://libexpat.github.io/"
pkg_license=('MIT')
pkg_source="https://github.com/libexpat/libexpat/archive/refs/tags/${_dl_version}.tar.gz"
pkg_shasum="f53a26fdf1c82e76e50856b1dcd3fc422f065c13a91c24cc1469aa01e654c30f"
pkg_dirname="libexpat-${_dl_version}"
pkg_deps=(
	core/coreutils
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
	core/autoconf
	core/automake
	core/libtool
	core/make
	core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
	cd ${CACHE_PATH}/expat
	fix_interpreter buildconf.sh core/coreutils bin/env
	libtoolize
	./buildconf.sh
	./configure --prefix=${pkg_prefix} CPPFLAGS=-DXML_LARGE_SIZE
	make -j "$(nproc)"
}

do_check() {
	cd ${CACHE_PATH}/expat
	fix_interpreter run.sh core/coreutils bin/env
	fix_interpreter test-driver-wrapper.sh core/coreutils bin/env

	# Set `LDFLAGS` for the c++ test code to find libstdc++
	make check LDFLAGS="$LDFLAGS -lstdc++"
}

do_install() {
	cd ${CACHE_PATH}/expat
	make install
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    core/gcc
    core/coreutils
  )
fi
