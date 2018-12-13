pkg_name=govc
pkg_origin=core
pkg_version="0.19.0"
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("Apache-2.0")
pkg_description="govc is a vSphere CLI built on top of govmomi."
pkg_upstream_url="https://github.com/vmware/govmomi"
pkg_source="https://github.com/vmware/govmomi"
pkg_bin_dirs=(bin)

pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/git)

do_before() {
  GOPATH="${HAB_CACHE_SRC_PATH}/govc-${pkg_version}"
}

do_verify() {
  return 0
}

do_unpack() {
  git clone "$pkg_source" "$GOPATH"
  ( cd "$GOPATH" || exit
    git checkout -q v"$pkg_version"
  )
}

do_download() {
  return 0
}

do_build() { 
 ( cd "$GOPATH/govc" || exit
   go build
 )
}

do_install() {
  cp "${GOPATH}/govc/govc" "${pkg_prefix}/bin/"
}

