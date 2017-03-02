pkg_name=hdf5
pkg_description="The Hierarchical Data Format (HDF) implements a model for managing and storing data"
pkg_origin=core
pkg_version=1.8.17
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('bsd' 'hdf5')
pkg_source=http://www.hdfgroup.org/ftp/HDF5/current/src/${pkg_name}-${pkg_version}.tar
pkg_upstream_url=https://www.hdfgroup.org
pkg_shasum=19add63bc9460bc97c808453d44923907a859e9ac7f6a66766ebb835bdfc5678
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils-static
  core/diffutils
  core/gcc
  core/make
  core/pcre
  core/which
  core/zlib
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  grep -lr '/bin/mv' . | while read -r f; do
    sed -e 's,/bin/mv,mv,g' -i "$f"
  done
  ./configure  --with-zlib="$(hab pkg path core/zlib)"/lib --prefix="$pkg_prefix"
}

do_build() {
  make
}

do_install () {
  LD_LIBRARY_PATH="$(hab pkg path core/zlib)"/lib
  #make check
  make install
  make check-install
}
