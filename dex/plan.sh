gopkg="github.com/dexidp/dex"
pkg_name=dex
pkg_description="OpenID Connect Identity (OIDC) and OAuth 2.0 Provider with Pluggable Connectors"
pkg_origin=core
pkg_version="2.27.0"
pkg_maintainer="Chef Software Inc. <support@chef.io>"
pkg_license=("Apache-2.0")
pkg_source="https://$gopkg/archive/v${pkg_version}.tar.gz"
pkg_shasum="2c031cc373c6caa40a5a9cdcb17b17ba85ec96ef5f16410715994bd5bf155bc2"
pkg_upstream_url="https://$gopkg"
pkg_exports=(
  [port]=service.port
  [host]=service.host
)
pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/git core/gcc)
pkg_bin_dirs=(bin)

do_build() {
  cat >scripts/git-version <<EOF
#!/bin/sh
echo "v${pkg_version}"
EOF
  make build
}

do_install() {
  cp bin/dex "$pkg_prefix/bin"
  cp -r "web" "$pkg_prefix"
}
