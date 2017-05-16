pkg_name=kubectl
pkg_origin=core
pkg_license=('Apache 2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version="1.6.3"
pkg_source="https://storage.googleapis.com/kubernetes-release/release/v${pkg_version}/bin/linux/amd64/kubectl"
pkg_shasum="2e9872fe2409deee257434a8c45976a4e1cc3f2e4e2a972fd85e86127a1f7cbd"
pkg_build_deps=(core/curl)
pkg_bin_dirs=(bin)

do_begin() {
  return 0
}

do_download() {
    mkdir -p $HAB_CACHE_SRC_PATH/${pkg_dirname}

    cd $HAB_CACHE_SRC_PATH/${pkg_dirname}
    
    curl -o ${pkg_dirname} -s ${pkg_source}
}

do_verify(){
  return 0
}

do_clean(){
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
  return 0
}

do_build() {
  return 0
}

do_check() {
  return 0
}

do_install() {
  mkdir -p ${pkg_prefix}/bin
  cp ${HAB_CACHE_SRC_PATH}/${pkg_dirname}/${pkg_dirname} ${pkg_prefix}/bin/${pkg_name}
  chmod 0755 ${pkg_prefix}/bin/${pkg_name}
}

do_strip() {
  return 0
}

do_end() {
  return 0
}

