pkg_origin=core
pkg_name=icu52
pkg_version=52.1
pkg_description="$(cat << EOF
  ICU is a mature, widely used set of C/C++ and Java libraries providing
  Unicode and Globalization support for software applications. ICU is widely
  portable and gives applications the same results on all platforms and
  between C/C++ and Java software.
EOF
)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Unicode-TOU")
# shellcheck disable=SC2059
pkg_source="http://download.icu-project.org/files/icu4c/${pkg_version}/icu4c-$(printf "%s" "$pkg_version" | tr . _)-src.tgz"
pkg_shasum=2f4d5e68d4698e87759dbdc1a586d053d96935787f79961d192c477b029d8092
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=icu/source
