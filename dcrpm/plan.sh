pkg_name=dcrpm
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-only')
pkg_description='dcrpm ("detect and correct rpm") is a tool to detect and correct common issues around RPM database corruption'
pkg_upstream_url=https://github.com/facebookincubator/dcrpm
pkg_build_deps=(
  core/gawk
  core/gcc
)
pkg_deps=(
  core/db
  core/lsof
  core/python
  core/rpm
)
pkg_bin_dirs=(bin)

pkg_version() {
  export LC_ALL=en_US LANG=en_US
  pip search --disable-pip-version-check $pkg_name | grep "^$pkg_name (" | awk -F'[()]' '{print $2}'
}

do_before() {
  update_pkg_version
}

do_prepare() {
  python -m venv "$pkg_prefix"
  # shellcheck source=/dev/null
  source "$pkg_prefix/bin/activate"
}

do_build() {
  return 0
}

shopt -s extglob
do_install() {
  pip install "$pkg_name==$pkg_version"
  # Write out versions of all pip packages to package
  pip freeze > "$pkg_prefix/requirements.txt"

  # Cleanup other binaries
  cd "$pkg_prefix/bin"
  shopt -s extglob
  rm !(dcrpm|python)
  shopt -u extglob
}
shopt -u extglob

do_strip() {
  return 0
}
