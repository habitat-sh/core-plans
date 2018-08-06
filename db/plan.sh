pkg_name=db
pkg_origin=core
pkg_version=18.1.25
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Berkeley DB is a family of embedded key-value database libraries providing \
scalable high-performance data management services to applications.\
"
pkg_upstream_url="http://www.oracle.com/technetwork/database/database-technologies/berkeleydb/overview/index.html"
pkg_license=('custom')
# Oracle's official download link for Berkeley DB is now behind a login screen
# So using an alternative one
pkg_source="https://fossies.org/linux/misc/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="4aed1949fe10a2bf37bc559cdca96ccf93b1d7de4f4dbeb3e5f5224d2c4eb8a7"
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  pushd build_unix > /dev/null
  ../dist/configure \
    --prefix="${pkg_prefix}" \
    --enable-compat185 \
    --enable-cxx \
    --enable-dbm \
    --enable-stl
  make LIBSO_LIBS=-lpthread -j"$(nproc)"
  popd > /dev/null
}

do_install() {
  pushd build_unix > /dev/null
  do_default_install
  make uninstall_docs
  popd > /dev/null

  # Install license file
  install -Dm644 LICENSE "${pkg_prefix}/share/licenses/LICENSE"
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    core/gcc
    core/coreutils
  )
fi
