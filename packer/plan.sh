pkg_name=packer
pkg_origin=core
pkg_version=0.12.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL2')
pkg_source=https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=035d0ea1fe785ab6b673bc2a79399125d4014f29151e106635fa818bb726bebf
pkg_description="Packer is a tool for creating machine and container images for multiple platforms from a single source configuration."
pkg_upstream_url=packer.io
pkg_dirname=$pkg_name
pkg_bin_dirs=(bin)

do_unpack() {
  pushd "${HAB_CACHE_SRC_PATH}"
    unzip "${pkg_filename}" -d "packer"
  popd
}

do_build() {
  return 0
}

do_install() {
  install -v "packer" "$pkg_prefix/bin/"
}
