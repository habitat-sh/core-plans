pkg_origin=core
pkg_name=vault
pkg_version=0.6.2
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("MPL-2.0")
pkg_upstream_url=https://www.vaultproject.io/
pkg_source=https://releases.hashicorp.com/vault/${pkg_version}/vault_${pkg_version}_linux_amd64.zip
pkg_shasum=91432c812b1264306f8d1ecf7dd237c3d7a8b2b6aebf4f887e487c4e7f69338c
pkg_filename=${pkg_name}-${pkg_version}_linux_amd64.zip
pkg_deps=()
pkg_build_deps=(core/unzip)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(8200)
pkg_svc_user=root

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip ${pkg_filename} -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D vault "${pkg_prefix}"/bin/vault
}
