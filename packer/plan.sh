pkg_name=packer
pkg_origin=core
pkg_version=1.5.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL2')
pkg_source="https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_shasum=2abb95dc3a5fcfb9bf10ced8e0dd51d2a9e6582a1de1cab8ccec650101c1f9df
pkg_description="Packer is a tool for creating machine and container images for multiple platforms from a single source configuration."
pkg_upstream_url=https://packer.io
pkg_build_deps=(core/unzip)
pkg_bin_dirs=(bin)

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip "${pkg_filename}" -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D packer "${pkg_prefix}/bin/packer"
}
