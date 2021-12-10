pkg_name=liberation-fonts-ttf
pkg_origin=core
pkg_version="2.1.5"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('OFL-1.1')
pkg_source="https://github.com/liberationfonts/liberation-fonts/files/7261482/$pkg_name-$pkg_version.tar.gz"
pkg_shasum="7191c669bf38899f73a2094ed00f7b800553364f90e2637010a69c0e268f25d0"
pkg_deps=(core/fontconfig)
pkg_description="The Liberation Fonts are intended to be replacements for the three most commonly used fonts on Microsoft systems: Times New Roman, Arial, and Courier New."
pkg_upstream_url="https://pagure.io/liberation-fonts"

do_build() {
  return 0
}

do_install() {
  mv ./*ttf "$pkg_prefix/"
}
