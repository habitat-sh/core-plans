pkg_name=terraform
pkg_origin=core
pkg_version=0.12.0
pkg_license=('MPL-2.0')
pkg_description="Terraform is a tool for building, changing, and combining infrastructure safely and efficiently"
pkg_upstream_url="http://www.terraform.io/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_filename="${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_shasum=42ffd2db97853d5249621d071f4babeed8f5fdba40e3685e6c1013b9b7b25830
pkg_build_deps=(core/unzip)
pkg_deps=()
pkg_bin_dirs=(bin)

# The pkg_filename does not extract into a folder. We need to force it.
do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip "${pkg_filename}" -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D terraform "${pkg_prefix}/bin/terraform"
}
