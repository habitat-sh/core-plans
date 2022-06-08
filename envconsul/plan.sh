pkg_name=envconsul
pkg_origin=core
pkg_version=0.12.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MPL-2.0")
pkg_description="Launch a subprocess with environment variables using data from @HashiCorp Consul and Vault."
pkg_upstream_url=https://github.com/hashicorp/envconsul
pkg_source="https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_shasum=361628aada03816d25ff13f4a0938953beda57f3a4ccd60e4278343762b95f6a
pkg_filename="${pkg_name}-${pkg_version}_linux_amd64.zip"
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
  install -D "${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
