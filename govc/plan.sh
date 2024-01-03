pkg_name=govc
pkg_origin=core
pkg_version="0.27.1"
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("Apache-2.0")
pkg_description="govc is a vSphere CLI built on top of govmomi."
pkg_upstream_url="https://github.com/vmware/govmomi"
pkg_source="https://github.com/vmware/govmomi"
pkg_bin_dirs=(bin)

pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/git core/gcc core/cacerts)


do_before() {
  GOPATH="${HAB_CACHE_SRC_PATH}/govc-${pkg_version}"
  go_pkg="${pkg_source#https://}"
  export GOPATH
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_verify() {
  return 0
}

do_unpack() {
  git clone \
    --quiet \
    --config advice.detachedHead=false \
    --branch v"${pkg_version}" \
    "${pkg_source}" \
    "${GOPATH}"/src/"${go_pkg}"
}

do_download() {
  return 0
}

do_build() {
 ( cd "src/${go_pkg}/govc" || exit
   go build
 )
}

do_install() {
  cp "src/${go_pkg}/govc/govc" "${pkg_prefix}/bin/"
}
