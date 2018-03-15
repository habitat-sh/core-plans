pkg_name="img"
pkg_origin="core"
pkg_version=0.3.0
pkg_description="Standalone, daemon-less, unprivileged Dockerfile and OCI compatible container image builder."
pkg_upstream_url="https://github.com/genuinetools/img"
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/genuinetools/img"
pkg_shasum="37fb69555f178370a67568e0004c7e67a048673fd26e7ab29e327c3ccdb57ace"
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
