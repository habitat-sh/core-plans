pkg_name=terraform
pkg_origin=core
pkg_version=0.12.11
pkg_license=('MPL-2.0')
pkg_description="Terraform is a tool for building, changing, and combining infrastructure safely and efficiently"
pkg_upstream_url="http://www.terraform.io/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_filename="${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_shasum=d61f8758a25bc079bb0833b81f998fbc4cf03bb0f41b995e08204cf5978f700e
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
