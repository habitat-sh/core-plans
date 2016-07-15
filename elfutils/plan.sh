pkg_name=elfutils
pkg_origin=core
pkg_version=0.166
pkg_license=('GPL-3.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="elfutils is a collection of various binary tools such as
  eu-objdump, eu-readelf, and other utilities that allow you to inspect and
  manipulate ELF files."
pkg_upstream_url=https://fedorahosted.org/elfutils/
pkg_source=https://fedorahosted.org/releases/e/l/$pkg_name/$pkg_version/$pkg_name-$pkg_version.tar.bz2
pkg_shasum=3c056914c8a438b210be0d790463b960fc79d234c3f05ce707cbff80e94cba30
pkg_deps=(
  core/glibc
  core/zlib
)
pkg_build_deps=(
  core/gcc
  core/glibc
  core/m4
  core/make
  core/zlib
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
