pkg_name=terraform
pkg_origin=core
pkg_version=0.12.12
pkg_license=('MPL-2.0')
pkg_description="Terraform is a tool for building, changing, and combining infrastructure safely and efficiently"
pkg_upstream_url="http://www.terraform.io/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_filename="${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_shasum=67bc7a49c0946ad48b14cc6e95482fdd3e7e9f7dc6811f4ce6ff531fc565bd3a
pkg_build_deps=(core/unzip)
pkg_deps=()
pkg_bin_dirs=(bin)

# The pkg_filename does not extract into a folder. We need to force it.
do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip "${pkg_filename}" -d "${pkg_dirname}"
}

do_build() {
  return 0
}

do_install() {
  install -D terraform "${pkg_prefix}/bin/terraform"
}
