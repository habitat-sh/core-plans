source ../bzip2/plan.sh

pkg_name=bzip2-musl
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
bzip2 is a free and open-source file compression program that uses the \
Burrows–Wheeler algorithm. It only compresses single files and is not a file \
archiver.\
"
pkg_upstream_url="http://www.bzip.org/"
pkg_license=('bzip2')
pkg_deps=(
  core/musl
)

do_prepare() {
  _common_prepare

  export CC=musl-gcc
  build_line "Setting CC=$CC"

  dynamic_linker="$(pkg_path_for musl)/lib/ld-musl-x86_64.so.1"
  LDFLAGS="$LDFLAGS -Wl,--dynamic-linker=$dynamic_linker"
}
