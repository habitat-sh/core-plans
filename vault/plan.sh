pkg_origin=core
pkg_name=vault
pkg_version=0.6.2
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("Apache 2")
pkg_upstream=https://www.vaultproject.io/
pkg_source=https://releases.hashicorp.com/vault/${pkg_version}/vault_${pkg_version}_linux_amd64.zip
pkg_filename=${pkg_name}-${pkg_version}.zip
pkg_deps=()
pkg_build_deps=(core/unzip)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_expose=(8200)
pkg_svc_user=root

do_download() {
  wget -O $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_source
}

do_verify() {
    return 0
}

do_unpack() {
    return 0
}

do_build() {
    return 0
}

do_install() {
  cp $HAB_CACHE_SRC_PATH/$pkg_filename $pkg_prefix
  cd ${pkg_prefix}
  unzip ${pkg_filename}
  mkdir bin
  mv vault bin/
  chmod 755 ${pkg_prefix}/bin/vault
}
