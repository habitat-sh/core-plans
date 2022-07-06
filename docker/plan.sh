pkg_name=docker
pkg_description="The Docker Engine"
pkg_origin=core
pkg_version=19.03.15
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_source="https://download.docker.com/linux/static/stable/x86_64/${pkg_name}-${pkg_version}.tgz"
pkg_upstream_url=https://docs.docker.com/engine/installation/binaries/
pkg_shasum=5504d190eef37355231325c176686d51ade6e0cabe2da526d561a38d8611506f
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
