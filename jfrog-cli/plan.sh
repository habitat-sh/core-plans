pkg_name=jfrog-cli
pkg_description="jfrog CLI"
pkg_origin=core
pkg_version=1.52.0
pkg_license=('apachev2')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/jfrog/jfrog-cli/archive/refs/tags/v${pkg_version}.tar.gz
pkg_shasum=05f822723f8d31b15d4a3acfdfa51757d69a41ef109cf61f98a2ab0041412396
pkg_deps=(core/glibc core/busybox-static core/cacerts)
pkg_build_deps=(core/coreutils)
pkg_bin_dirs=(bin)
pkg_upstream_url="https://github.com/JFrogDev/jfrog-cli-go"

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  install -D "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/jfrog"
  cgo_wrap_binary jfrog
}

cgo_wrap_binary() {
  local bin="$pkg_prefix/bin/$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  local certs
  certs="$(pkg_path_for cacerts)/ssl/cert.pem"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
if [ ! -f "/etc/ssl/certs/ca-certificates.crt" ]; then
  echo "Adding symlink of $certs under /etc"
  mkdir -p /etc/ssl/certs
  ln -snf $certs /etc/ssl/certs/ca-certificates.crt
fi
export LD_LIBRARY_PATH="$LD_RUN_PATH"
exec $(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2 ${bin}.real \$@
EOF
  chmod -v 755 "$bin"
}
