gopkg="github.com/dexidp/dex"
pkg_name=dex
pkg_description="OpenID Connect Identity (OIDC) and OAuth 2.0 Provider with Pluggable Connectors"
pkg_origin=core
pkg_version=2.30.2
pkg_maintainer="Chef Software Inc. <support@chef.io>"
pkg_license=("Apache-2.0")
pkg_source=https://$gopkg
pkg_upstream_url=https://dexidp.io
pkg_exports=(
  [port]=service.port
  [host]=service.host
)
pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/git core/gcc core/cacerts)
pkg_bin_dirs=(bin)

do_before() {
  GOPATH=$HAB_CACHE_SRC_PATH/$pkg_dirname
  export GOPATH
}

do_prepare() {
  export GO_LDFLAGS="-w -X $gopkg/version.Version=v$pkg_version"
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_download() {
  return 0
}

do_verify() {
  return 0
}

# Use unpack instead of download, so that plan-build can manage the
# source path. This ensures us a clean checkout every time we build.
do_unpack() {
  git clone "$pkg_source" "$GOPATH/src/$gopkg"
  ( cd "$GOPATH/src/$gopkg" || exit
    git reset --hard "v$pkg_version"
  )
}

do_build() {
  cd "$GOPATH/src/$gopkg"
  go build --ldflags "${GO_LDFLAGS}" -o "$pkg_prefix/bin/dex" "$gopkg/cmd/dex"
}

do_install() {
  cp -r "$GOPATH/src/$gopkg/web" "$pkg_prefix"
}
