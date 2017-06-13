pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=17.05.0-ce
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://get.docker.com/builds/Linux/x86_64/${pkg_name}-${pkg_version}.tgz
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=340e0b5a009ba70e1b644136b94d13824db0aeb52e09071410f35a95d94316d9
pkg_dirname=docker
pkg_deps=()
pkg_build_deps=()
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  for bin in docker dockerd $(ls -1 docker-*); do
    install -v -D "$bin" "$pkg_prefix/bin/$bin"
  done
}
