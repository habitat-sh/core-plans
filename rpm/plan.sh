pkg_name=rpm
pkg_origin=core
pkg_version=4.17.0
pkg_license=("GPL-2.0" "LGPL-2.0")
pkg_description="RPM Package Manager"
pkg_upstream_url="http://www.rpm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://ftp.osuosl.org/pub/rpm/releases/rpm-4.17.x/rpm-${pkg_version}.tar.bz2
pkg_shasum=2e0d220b24749b17810ed181ac1ed005a56bbb6bc8ac429c21f314068dc65e6a

pkg_deps=(
  core/bzip2
  core/db
  core/file
  core/glibc
  core/libarchive
  core/nspr
  core/nss
  core/openssl
  core/popt
  core/zlib
  core/libgcrypt
)

pkg_build_deps=(
  core/gcc
  core/make
	core/autoconf
	core/automake
	core/gettext
	core/libtool
	core/pkg-config
	core/lua
)

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
	export LUA_LIBS="$LDFLAGS -llua -lm"
	export LUA_CFLAGS="$CFLAGS"
	ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/pkg-config)/share/aclocal"
	ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/automake)/share/aclocal"
	ACLOCAL_PATH="${ACLOCAL_PATH}:$(pkg_path_for core/libtool)/share/aclocal"
	ACLOCAL_PATH="$ACLOCAL_PATH:$(pkg_path_for core/autoconf)/share/autoconf"
	ACLOCAL_PATH="$ACLOCAL_PATH:$HAB_CACHE_SRC_PATH/$pkg_dirname/m4"
	export ACLOCAL_PATH
	./autogen.sh --noconfigure
	./configure --prefix=${pkg_prefix} --enable-sqlite=no
	make
}
