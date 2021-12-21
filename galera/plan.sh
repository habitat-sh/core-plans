pkg_name=galera
pkg_origin=core
pkg_version=25.3.35
pkg_source=http://github.com/codership/galera/archive/release_${pkg_version}.tar.gz
pkg_upstream_url=https://github.com/codership/galera
pkg_shasum=2025c80aba0dc23b0e30bd9bb05479f01fae0ff9c50fbbed211c5649e878f9ef
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Galera WSREP plugin"
pkg_license=('GPL-2.0-only')
pkg_lib_dirs=(lib)
pkg_deps=(
  core/gcc-libs
  core/openssl
  core/glibc
)
pkg_build_deps=(
  core/scons
  core/python2
  core/gcc
  core/boost
  core/check
  core/patch
)
pkg_dirname="galera-release_${pkg_version}"

do_prepare() {
	do_default_prepare
	# download wsrep-api; required as dependency to build package
	wget https://github.com/codership/wsrep-API/archive/refs/tags/release_v25.tar.gz
	tar zxf release_v25.tar.gz -C wsrep/src --strip-component=1
}

do_build() {
  scons strict_build_flags=0 tests=0
}

do_install() {
  mkdir -p "${pkg_prefix}/lib"
  cp libgalera_smm.so "${pkg_prefix}/lib"
}
