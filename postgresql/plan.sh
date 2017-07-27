pkg_name=postgresql
pkg_version=9.6.3
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=1645b3736901f6d854e695a937389e68ff2066ce0cde9d73919d6ab7c995b9c6
pkg_deps=(
  core/bash
  core/envdir
  core/glibc
  core/openssl
  core/perl
  core/readline
  core/zlib
  core/libossp-uuid
  core/wal-e
)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=port
  [superuser_name]=superuser.name
  [superuser_password]=superuser.password
)
pkg_exposes=(port)

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

do_build() {
	# ld manpage: "If -rpath is not used when linking an ELF
	# executable, the contents of the environment variable LD_RUN_PATH
	# will be used if it is defined"
	./configure --disable-rpath \
              --with-openssl \
              --prefix="$pkg_prefix" \
              --with-uuid=ossp \
              --with-includes="$LD_INCLUDE_PATH" \
              --with-libraries="$LD_LIBRARY_PATH" \
              --sysconfdir="$pkg_svc_config_path" \
              --localstatedir="$pkg_svc_var_path"
	make world
}

do_install() {
  make install-world
}
