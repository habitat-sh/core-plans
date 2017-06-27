pkg_name=liberation-fonts-ttf
pkg_origin=core
pkg_version="2.00.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('OFL-1.1')
pkg_source="https://releases.pagure.org/liberation-fonts/$pkg_name-$pkg_version.tar.gz"
pkg_shasum="7890278a6cd17873c57d9cd785c2d230d9abdea837e96516019c5885dd271504"
pkg_deps=(core/fontconfig)
pkg_description="The Liberation Fonts are intended to be replacements for the three most commonly used fonts on Microsoft systems: Times New Roman, Arial, and Courier New."
pkg_upstream_url="https://pagure.io/liberation-fonts"

do_build() {
  return 0
}

do_install() {
  mv ./*ttf "$pkg_prefix/"
}
