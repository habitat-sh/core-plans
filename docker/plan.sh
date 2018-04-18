pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=18.03.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source=https://download.docker.com/linux/static/stable/x86_64/${pkg_name}-${pkg_version}-ce.tgz
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=e5dff6245172081dbf14285dafe4dede761f8bc1750310156b89928dbf56a9ee
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
