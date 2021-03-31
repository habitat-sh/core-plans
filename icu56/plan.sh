pkg_origin=core
pkg_name=icu56
pkg_version=56.2
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
pkg_source="https://github.com/unicode-org/icu/releases/download/release-${pkg_version//./-}/icu4c-${pkg_version//./_}-src.tgz"
pkg_shasum=5568abc4f3be6de512c5972892743ae32a4a2214dd76632e53eccd80d655cd07
pkg_upstream_url="http://site.icu-project.org/"
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_dirname=icu/source
