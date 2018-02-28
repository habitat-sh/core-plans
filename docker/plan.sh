pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=17.09.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://download.docker.com/linux/static/stable/x86_64/${pkg_name}-${pkg_version}-ce.tgz
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=77d3eaa72f2b63c94ea827b548f4a8b572b754a431c59258e3f2730411f64be7
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
