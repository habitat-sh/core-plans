pkg_name=packer
pkg_origin=core
pkg_version=1.3.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL2')
pkg_source="https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_shasum="0512af351124e63f8079458391e7f7b316e4b3ac4dc40e6f18058fd924f1b24a"
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
  install -D packer "$pkg_prefix/bin/packer"
}
