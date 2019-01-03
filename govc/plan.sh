pkg_name=govc
pkg_origin=core
pkg_version="0.19.0"
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("Apache-2.0")
pkg_description="govc is a vSphere CLI built on top of govmomi."
pkg_upstream_url="https://github.com/vmware/govmomi"
pkg_source="https://github.com/vmware/govmomi/archive/v0.19.0.tar.gz"
pkg_shasum="5d07c121cb562b5e24970e3d9d0f00ef7e1d9c79a3104dbd6965fc8cc4ef96a6"
pkg_dirname="govmomi-${pkg_version}"
pkg_build_deps=(
  core/git
  core/go
  core/gcc
  core/make
)
pkg_deps=(
  core/gcc-libs
)
pkg_bin_dirs=(bin)

do_prepare() {
  export GOPATH="$HAB_CACHE_SRC_PATH"
  mkdir -p "$GOPATH/src/github.com/vmware/"
  cp -R "$HAB_CACHE_SRC_PATH/${pkg_dirname}" "$GOPATH/src/github.com/vmware/govmomi"
  cp -R "$GOPATH/src/github.com/vmware/govmomi/vendor/"* "$GOPATH/src/"
}

do_check() {
  cd "$GOPATH/src/github.com/vmware/govmomi/govc"
  go test
}

do_build() {
  cd "$GOPATH/src/github.com/vmware/govmomi/govc"
  go build -o "$pkg_prefix/bin/govc"
}

do_install() {
  return 0
}
