pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=19.03.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source="https://download.docker.com/linux/static/stable/x86_64/${pkg_name}-${pkg_version}.tgz"
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=7f4115dc6a3c19c917f8b9664d7b51c904def1c984e082c4600097433323cf6f
pkg_dirname=docker
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  for bin in *; do
    install -v -D "${bin}" "${pkg_prefix}/bin/${bin}"
  done
}

# Skip stripping down the Go binaries
do_strip() {
  return 0
}
