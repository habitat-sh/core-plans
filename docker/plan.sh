pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=17.09.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://download.docker.com/linux/static/stable/x86_64/${pkg_name}-${pkg_version}-ce.tgz
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=a9e90a73c3cdfbf238f148e1ec0eaff5eb181f92f35bdd938fd7dab18e1c4647
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
