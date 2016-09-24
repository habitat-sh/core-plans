pkg_name=ngrok
pkg_origin=core
pkg_version=_set_from_downloaded_zip_file_
pkg_description="Expose local servers behind NATs and firewalls to the public internet over secure tunnels."
pkg_upstream_url=https://ngrok.com/
pkg_license=('proprietary')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
pkg_dirname=ngrok-unknown
pkg_bin_dirs=(bin)
pkg_deps=(core/busybox-static)
pkg_build_deps=(core/coreutils)

do_verify() {
  return 0
}

do_unpack() {
  rm -rvf "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  mkdir -pv "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname" > /dev/null
    unzip "$HAB_CACHE_SRC_PATH/$pkg_filename"
    update_pkg_version
  popd > /dev/null
}

do_build() {
  return 0
}

do_install() {
  install -v -D ngrok "$pkg_prefix/bin/ngrok"

  # Add a default configuration to not auto-update
  mkdir -pv "$pkg_prefix/etc"
  echo "update: false" > "$pkg_prefix/etc/ngrok.yml"

  # Add a wrapper for ngrok to properly set SSL certificates and use the
  # default config
  wrapper_for ngrok
}

wrapper_for() {
  local bin="$pkg_prefix/bin/$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
case \$1 in
  http|start|tcp|tls)
    cmd=\$1
    shift
    args="\$cmd --config $pkg_prefix/etc/ngrok.yml \$@"
    ;;
  *)
    args="\$@"
    ;;
esac
exec ${bin}.real \$args
EOF
  chmod -v 755 "$bin"
}

do_strip() {
  return 0
}

update_pkg_version() {
  # Find the version in the extracted src directory in the `version` file
  pkg_version=$(env USER=root ./ngrok version | cut -d ' ' -f 3)
  build_line "Version updated to $pkg_version from extracted distribution"
  # Several metadata values get their defaults from the value of `$pkg_version`
  # so we must update these as well
  pkg_prefix=$HAB_PKG_PATH/${pkg_origin}/${pkg_name}/${pkg_version}/${pkg_release}
  pkg_artifact="$HAB_CACHE_ARTIFACT_PATH/${pkg_origin}-${pkg_name}-${pkg_version}-${pkg_release}-${pkg_target}.${_artifact_ext}"
}
