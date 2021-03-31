pkg_name=libunwind
pkg_origin=core
pkg_version=1.4.0
pkg_description="A C programming interface to determine the call-chain of a program."
pkg_upstream_url="http://www.nongnu.org/libunwind/"
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.savannah.gnu.org/releases/libunwind/libunwind-${pkg_version}.tar.gz"
pkg_shasum=df59c931bd4d7ebfd83ee481c943edf015138089b8e50abed8d9c57ba9338435
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/gcc
  core/make
  core/diffutils
  core/file
  core/coreutils
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  _file_path="$(pkg_path_for file)/bin/file"
  sed -e "s#/usr/bin/file#${_file_path}#g" -i configure

  # /bin/ls is required for some of the tests
  if [[ ! -r /bin/ls ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/ls" /bin/ls
    _clean_ls=true
  fi
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_ls" ]]; then
    rm -fv /bin/ls
  fi
}
