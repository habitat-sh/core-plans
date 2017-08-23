pkg_name=dex
pkg_description="OpenID Connect Identity (OIDC) and OAuth 2.0 Provider with Pluggable Connectors"
pkg_origin=core
pkg_version="v2.6.1"
pkg_maintainer="Chef Software Inc. <support@chef.io>"
pkg_license=("Apache-2.0")
pkg_source="http://github.com/coreos/dex"
pkg_upstream_url=$pkg_source
pkg_build_deps=()
pkg_exports=(
  [port]=service.port
  [host]=service.host
)
pkg_deps=()
pkg_bin_dirs=(bin)
pkg_scaffolding=core/scaffolding-go
scaffolding_go_base_path=github.com/coreos
scaffolding_go_build_deps=()

do_prepare() {
  build_line "GO_LDFLAGS=\"-w -X $scaffolding_go_base_path/dex/version.Version=$pkg_version\""
  export GO_LDFLAGS="-w -X $scaffolding_go_base_path/dex/version.Version=$pkg_version"
}

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  build_line "go get -d github.com/coreos/dex"
  go get -d github.com/coreos/dex

  pushd "$scaffolding_go_src_path"
    build_line "checking out $pkg_version"
    git reset --hard $pkg_version
  popd
}

do_build() {
  build_line "go build --ldflags \"${GO_LDFLAGS}\" -o bin/dex $scaffolding_go_base_path/dex/cmd/dex"
  go build --ldflags "${GO_LDFLAGS}" -o bin/dex $scaffolding_go_base_path/dex/cmd/dex
}

do_install() {
  build_line "copying dex binary"
  cp -r "${scaffolding_go_gopath:?}/bin" "$pkg_prefix"
  build_line "copying static web content"
  cp -r "${scaffolding_go_gopath:?}/src/${scaffolding_go_base_path:?}/dex/web" "$pkg_prefix"
}
