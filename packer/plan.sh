pkg_name=packer
pkg_origin=core
pkg_version=1.2.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL2')
pkg_source=https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=dd90f00b69c4d8f88a8d657fff0bb909c77ebb998afd1f77da110bc05e2ed9c3
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
