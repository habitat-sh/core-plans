gopkg="github.com/fullstorydev/grpcurl"
pkg_name=grpcurl
pkg_origin=core
pkg_version="1.8.5"
pkg_description="Like cURL, but for gRPC: Command-line tool for interacting with gRPC servers"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/fullstorydev/grpcurl/archive/v${pkg_version}.tar.gz"
pkg_upstream_url="https://$gopkg"
pkg_license=('MIT')
pkg_bin_dirs=(bin)
pkg_build_deps=(
    core/git
    core/go
)
pkg_shasum="1a9612560b2da18d50f0a46e9f2f5a7e5a13c4bb1ccef15ba65cb0c37335342b"

do_build() {
    return 0
}

do_install() {
    GO111MODULE=on CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build \
      -ldflags "-X 'main.version=v${pkg_version}'" \
      -o "${pkg_prefix}/bin" \
      ./cmd/grpcurl
}
