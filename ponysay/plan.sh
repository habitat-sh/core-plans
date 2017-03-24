pkg_name=ponysay
pkg_origin=core
pkg_version="3.0.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_source="https://github.com/erkin/$pkg_name/archive/$pkg_version.tar.gz"
pkg_shasum=69e98a7966353de2f232cbdaccd8ef7dbc5d0bcede9bf7280a676793e8625b0d
pkg_deps=(
  core/coreutils
  core/python
)
pkg_bin_dirs=(bin)
pkg_description="A cowsay reimplemention for ponies"
pkg_upstream_url="http://erkin.co/ponysay/"

do_build() {
  return 0
}

do_install() {
  fix_interpreter "./src/*.py" core/coreutils bin/env

  python3 setup.py \
    --freedom=partial \
    --prefix="$pkg_prefix" \
    --without-info-manual \
    --without-man-manual \
    --without-shared-cache \
    --without-shell-completion \
    install

  fix_interpreter "$pkg_prefix/bin/ponysay" core/coreutils bin/env
}

do_strip() {
  return 0
}
