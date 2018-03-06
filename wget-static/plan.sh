source ../wget/plan.sh

pkg_name=wget-static
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_dirname=${_distname}-${pkg_version}
pkg_description="\
GNU Wget is a free software package for retrieving files using HTTP, HTTPS, \
FTP and FTPS the most widely-used Internet protocols.\
"
pkg_upstream_url="https://www.gnu.org/software/wget/"
pkg_license=('GPL-3.0+')
# Empty out the run deps array
pkg_deps=()
# Throw the run deps into build deps as this will be static
pkg_build_deps=(
  core/linux-headers-musl
  core/musl
  "${pkg_build_deps[@]}"
  "${pkg_deps[@]}"
)

do_prepare() {
  CFLAGS="-I$(pkg_path_for linux-headers-musl)/include -I$(pkg_path_for musl)/include"
  build_line "Setting CFLAGS=$CFLAGS"

  LDFLAGS="-static $LDFLAGS"
  build_line "Setting LDFLAGS=$LDFLAGS"

  export CC=musl-gcc
  build_line "Setting CC=$CC"

  _wget_common_prepare
}
