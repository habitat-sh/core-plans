pkg_origin=core
pkg_name=vault
pkg_version=0.6.2
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("Apache 2")
pkg_upstream=https://www.vaultproject.io/
pkg_source=https://releases.hashicorp.com/vault/${pkg_version}/vault_${pkg_version}_linux_amd64.zip
pkg_shasum=91432c812b1264306f8d1ecf7dd237c3d7a8b2b6aebf4f887e487c4e7f69338c
pkg_filename=${pkg_name}-${pkg_version}.zip
pkg_deps=()
pkg_build_deps=(core/unzip core/wget)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(8200)
pkg_svc_user=root


do_download() {
  wget -O "${HAB_CACHE_SRC_PATH}"/"${pkg_filename}" ${pkg_source}
}

do_unpack() {
  mkdir -p "${pkg_prefix}"
  cp "${HAB_CACHE_SRC_PATH}"/"${pkg_filename}" "${pkg_prefix}"
  cd "${pkg_prefix}" || exit
  unzip ${pkg_filename}
  rm ${pkg_filename}
}

do_build() {
    return 0
}

do_install() {
  cd "${pkg_prefix}" || exit
  mkdir bin
  mv vault bin/
  chmod 755 "${pkg_prefix}"/bin/vault
}
