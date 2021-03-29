gopkg="github.com/fullstorydev/grpcurl"
pkg_name=grpcurl
pkg_origin=core
pkg_version="1.8.0"
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
pkg_shasum="3688ef37e8d821d6a89c68856d9ae68527e7a65b9c64ae380b37b37f1cdeff22"

do_build() {
    return 0
}

do_install() {
    GO111MODULE=on CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build \
      -ldflags "-X 'main.version=v${pkg_version}'" \
      -o "${pkg_prefix}/bin" \
      ./cmd/grpcurl
}
