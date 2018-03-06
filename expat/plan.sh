pkg_name=expat
pkg_origin=core
pkg_version=2.2.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Expat is a stream-oriented XML parser library written in C. Expat excels with \
files too large to fit RAM, and where performance and flexibility are crucial.\
"
pkg_upstream_url="https://libexpat.github.io/"
pkg_license=('MIT')
pkg_source="https://downloads.sourceforge.net/project/${pkg_name}/${pkg_name}/${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum="d9dc32efba7e74f788fcc4f212a43216fc37cf5f23f4c2339664d473353aedf6"
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

do_check() {
  # Remove shebang line containing `/usr/bin/env` in test helper
  sed -i 's,^#!.*bash$,,' run.sh

  # Set `LDFLAGS` for the c++ test code to find libstdc++
  make check LDFLAGS="$LDFLAGS -lstdc++"
}

do_install() {
  do_default_install

  # Install license file
  install -Dm644 COPYING "$pkgdir/share/licenses/COPYING"
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
