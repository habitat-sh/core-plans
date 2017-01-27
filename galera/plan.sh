pkg_name=galera
pkg_origin=core
pkg_version=25.3.19
pkg_source=http://github.com/codership/galera/archive/release_${pkg_version}.tar.gz
pkg_upstream_url=https://github.com/codership/galera
pkg_shasum=068b074ca5a5c2a5a3f799422650e7c5e5c9012ddfa1c18c30feab7f9aa9611d
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Galera WSREP plugin"
pkg_license=('GPL-2.0')
pkg_lib_dirs=(lib)
pkg_build_deps=(core/scons core/python2 core/gcc core/boost core/check core/openssl)
pkg_dirname="galera-release_${pkg_version}"

do_build() {
  scons strict_build_flags=0 tests=0
}

do_install() {
  mkdir -p "${pkg_prefix}/lib"
  cp libgalera_smm.so "${pkg_prefix}/lib"
}
