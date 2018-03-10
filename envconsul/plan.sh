pkg_name=envconsul
pkg_origin=core
pkg_version=0.7.3
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("MPL-2.0")
pkg_description="Launch a subprocess with environment variables using data from @HashiCorp Consul and Vault."
pkg_upstream_url=https://github.com/hashicorp/envconsul
pkg_source="https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip"
pkg_shasum="67ed44cb254da24ca5156ada6d04e3cfeba248ca0c50a5ddd42282cbafde80bc"
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
