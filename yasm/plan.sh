pkg_name=yasm
pkg_origin=core
pkg_version=1.3.0
pkg_description="Yasm is a complete rewrite of the NASM assembler"
pkg_upstream_url=http://yasm.tortall.net/
pkg_license=(
  'Artistic-1.0-Perl'
  'BSD-2-Clause' 'BSD-3-Clause'
  'GPL-2.0' 'LGPL-2.0'
)
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://www.tortall.net/projects/yasm/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=3dce6601b495f5b3d45b59f7d2492a340ee7e84b5beca17e48f862502bd5603f
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_build_deps=(core/diffutils core/gcc core/make)
pkg_deps=(core/glibc)

do_check() {
  make check
}
