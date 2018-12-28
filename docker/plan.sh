pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=18.09.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://download.docker.com/linux/static/stable/x86_64/${pkg_name}-${pkg_version}.tgz
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=08795696e852328d66753963249f4396af2295a7fe2847b839f7102e25e47cb9
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
