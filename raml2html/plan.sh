pkg_name=raml2html
pkg_origin=core
pkg_version="6.7.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_deps=(core/node)
pkg_description="RAML to HTML documentation generator."
pkg_upstream_url="https://github.com/raml2html/raml2html"
pkg_bin_dirs=(bin)

do_build() {
  env PREFIX="$CACHE_PATH" npm i -g "${pkg_name}@$pkg_version"
}

do_install() {
  local shebang
  shebang="#!$(pkg_path_for core/node)/bin/node"

  mv "$CACHE_PATH/lib/node_modules/$pkg_name"/* "$pkg_prefix/"

  find "$pkg_prefix/bin" -type f | while read -r bin; do
    build_line "Fixing Node shebang for $bin"
    sed -e "s|^#!.\{0,\}\$|${shebang}|" -i "${bin}"
  done
}

do_strip() {
  return 0
}
