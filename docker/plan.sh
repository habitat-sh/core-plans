pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=17.12.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://download.docker.com/linux/static/stable/x86_64/${pkg_name}-${pkg_version}-ce.tgz
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=692e1c72937f6214b1038def84463018d8e320c8eaf8530546c84c2f8f9c767d
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

# Skip stripping down the Go binaries
do_strip() {
  return 0
}
