pkg_name=handlebars-cmd
pkg_origin=core
pkg_version="0.1.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_deps=(
  core/coreutils
  core/node
)
pkg_build_deps=(
  core/git
)
pkg_description="handlebars command-line tool."
pkg_upstream_url="https://github.com/DavidBabel/handlebars-cmd"
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  # Use handlebars-cmd branch with a recent version of handlebars.
  # This is a silly problem & fix; if there is a .git folder/file in the source
  # directory during compilation npm will throw 'fatal: not a git repository'
  # error (This occurs in the refresh environment). This can be avoided by
  # being in any other directory since we're using --global and --prefix
  # regardless
  pushd $pkg_prefix
    # Use handlebars-cmd branch with a recent version of handlebars.
    npm install --global "DavidBabel/$pkg_name#c6176f1" --prefix="$pkg_prefix" --progress=false
    fix_interpreter "$pkg_prefix/bin/handlebars" core/coreutils bin/env
  popd
}
