pkg_name=packer
pkg_origin=core
pkg_version=1.2.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL2')
pkg_source=https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=258d1baa23498932baede9b40f2eca4ac363b86b32487b36f48f5102630e9fbb
pkg_description="Packer is a tool for creating machine and container images for multiple platforms from a single source configuration."
pkg_upstream_url=packer.io
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
  install -D packer "$pkg_prefix/bin/packer"
}
