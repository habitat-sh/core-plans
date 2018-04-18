pkg_name=docker17
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=17.12.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://download.docker.com/linux/static/stable/x86_64/docker-${pkg_version}-ce.tgz
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=1270dce1bd7e1838d62ae21d2505d87f16efc1d9074645571daaefdfd0c14054
pkg_dirname=docker
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  for bin in docker*; do
    install -v -D "$bin" "$pkg_prefix/bin/$bin"
  done
}

# Skip stripping down the Go binaries
do_strip() {
  return 0
}
