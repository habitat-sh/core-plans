pkg_origin=core
pkg_name=gox
pkg_version=master
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A dead simple, no frills Go cross compile tool"
pkg_license=("MPL-2.0")
pkg_source=https://github.com/mitchellh/gox/archive/master.tar.gz # I'm killing a kitten.
pkg_upstream_url=https://github.com/mitchellh/gox
pkg_shasum=62d24ff55069bb3b6d75277585d723fdca6fef524602090c46b466098d49f1ba
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
