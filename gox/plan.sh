pkg_origin=core
pkg_name=gox
pkg_version=0.4.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A dead simple, no frills Go cross compile tool"
pkg_license=("MPL-2.0")
pkg_source="https://github.com/mitchellh/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_upstream_url=https://github.com/mitchellh/gox
pkg_shasum=2df7439e9901877685ff4e6377de863c3c2ec4cde43d0ca631ff65d1b64774ad
pkg_build_deps=(core/git core/go)
pkg_bin_dirs=(bin)

do_prepare() {
  export GOPATH=$HAB_CACHE_SRC_PATH
}

do_build() {
  go get github.com/mitchellh/iochan # AKA Leftpad of the Go world
  go get github.com/hashicorp/go-version
  go build -o "${pkg_prefix}/bin/gox"
}

do_install() {
  return 0
}
