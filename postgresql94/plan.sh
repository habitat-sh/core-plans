pkg_name=postgresql94
pkg_version=9.4.9
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('PostgreSQL')
pkg_dirname=postgresql-${pkg_version}
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/postgresql-${pkg_version}.tar.bz2
pkg_shasum=c120a62e90214c20d9160da3ca3fbaec97d5f1656f1dd033f60e7297b7a1e1c9

pkg_deps=(
  core/glibc
  core/openssl
  core/perl
  core/readline
  core/zlib
)

pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
)

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(5432)

do_build() {
	# ld manpage: "If -rpath is not used when linking an ELF
	# executable, the contents of the environment variable LD_RUN_PATH
	# will be used if it is defined"
	./configure --disable-rpath \
              --with-openssl \
              --prefix=${pkg_prefix} \
              --sysconfdir=${pkg_svc_config_path} \
              --localstatedir=${pkg_svc_var_path}
	make
}
