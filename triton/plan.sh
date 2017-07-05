pkg_name=triton
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL-2.0')
pkg_deps=(core/node)
pkg_build_deps=(core/jq-static core/sed)
pkg_bin_dirs=(bin)
pkg_description="Joyent Triton CLI and client"
pkg_upstream_url="https://www.joyent.com/triton"

pkg_version () {
  npm view triton --json | jq --raw-output .version
}

do_before () {
  if [[ -n "$HAB_NONINTERACTIVE" ]]; then
    export NPM_CONFIG_PROGRESS=false
    build_line "Setting NPM_CONFIG_PROGRESS=$NPM_CONFIG_PROGRESS"
  fi

  update_pkg_version
}

do_build() {
  return 0
}

do_install() {
  npm install --global --prefix="$pkg_prefix" "$pkg_name@$pkg_version"
  # The thing that gets installed in bin is not a symlink but it should be
  ln -fsv "$pkg_prefix/lib/node_modules/$pkg_name/bin/$pkg_name" "$pkg_prefix/bin/$pkg_name"
  # Replace `#!/usr/bin/env node` with actual node location
  sed -i "1c#!$(pkg_path_for node)/bin/node" "$pkg_prefix/lib/node_modules/$pkg_name/bin/$pkg_name"
}

do_strip() {
  return 0
}
