pkg_name="img"
pkg_origin="core"
pkg_version=0.2.4
pkg_description="Standalone, daemon-less, unprivileged Dockerfile and OCI compatible container image builder."
pkg_upstream_url="https://github.com/genuinetools/img"
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/genuinetools/img"
pkg_shasum="73549dc3eb29005dae5248385c6b40310a323b817714853d35d7194abfa357b8"
pkg_bin_dirs=(bin)
pkg_scaffolding=core/scaffolding-go
pkg_deps=(core/runc core/git)

do_build() {
  export PATH="$PATH:$GOPATH/bin"
  pushd "$scaffolding_go_pkg_path" >/dev/null
  make clean
  make static
  popd >/dev/null
}
