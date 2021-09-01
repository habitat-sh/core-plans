pkg_name=certstrap
pkg_description="A simple certificate manager written in Go, to bootstrap your own certificate authority and public key infrastructure. Adapted from etcd-ca."
pkg_upstream_url="https://github.com/square/certstrap"
pkg_origin=core
pkg_version="v1.2.0"
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("Apache-2.0")
pkg_source="https://github.com/square/certstrap"
pkg_bin_dirs=(bin)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_scaffolding=core/scaffolding-go
scaffolding_go_base_path=github.com/square
scaffolding_go_build_deps=()

do_prepare() {
  build_line "adding \$GOPATH/bin to \$PATH"
  export PATH=${scaffolding_go_gopath:?}/bin:$PATH

  build_line "building godep"
  go get github.com/tools/godep
}

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  build_line "go get -d github.com/square/certstrap"
  go get -d github.com/square/certstrap

  pushd "${scaffolding_go_pkg_path:?}"
    build_line "checking out $pkg_version"
    git reset --hard $pkg_version
  popd
}

do_build() {
  pushd "${scaffolding_go_pkg_path:?}"
    go mod vendor
    build_line "building certstrap"
    GOARCH=amd64 GOOS=linux go build -o bin/certstrap github.com/square/certstrap
  popd
}

do_install() {
  build_line "copying certstrap binary"
  cp "${scaffolding_go_pkg_path:?}/bin/certstrap" "${pkg_prefix}/bin"
}
