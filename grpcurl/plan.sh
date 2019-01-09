gopkg="github.com/fullstorydev/grpcurl"
pkg_name=grpcurl
pkg_origin=core
pkg_description="Like cURL, but for gRPC: Command-line tool for interacting with gRPC servers"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://$gopkg/cmd/grpcurl"
pkg_upstream_url="https://$gopkg"
pkg_version="1.1.0"
pkg_license=('MIT')
pkg_bin_dirs=(bin)
pkg_scaffolding=core/scaffolding-go
scaffolding_go_base_path=github.com/fullstorydev

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  go get -d $gopkg

  pushd "${scaffolding_go_gopath:?}/src/$gopkg"
    git reset --hard "v$pkg_version"
  popd
}

do_build() {
  pushd "${scaffolding_go_gopath:?}/src/$gopkg"
    make install
  popd
}

do_install() {
  cp "${scaffolding_go_gopath:?}/bin/grpcurl" "${pkg_prefix}/bin/"
}
