pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=1.12.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://get.docker.com/builds/Linux/x86_64/${pkg_name}-${pkg_version}.tgz
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=626601deb41d9706ac98da23f673af6c0d4631c4d194a677a9a1a07d7219fa0f
pkg_dirname=docker
pkg_deps=()
pkg_build_deps=()
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  for bin in docker $(ls -1 docker-*); do
    install -v -D "$bin" "$pkg_prefix/bin/$bin"
  done
}
