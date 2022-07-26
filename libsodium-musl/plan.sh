pkg_name=libsodium-musl
_distname=libsodium
pkg_version="1.0.18"
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Sodium is a new, easy-to-use software library for encryption, decryption, \
signatures, password hashing and more. It is a portable, cross-compilable, \
installable, packageable fork of NaCl, with a compatible API, and an extended \
API to improve usability even further.\
"
pkg_upstream_url="https://github.com/jedisct1/libsodium"
pkg_license=('libsodium')
pkg_source="https://download.libsodium.org/libsodium/releases/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="6f504490b342a4f8a4c4a02fc9b866cbef8622d5df4e5452b46be121e46636c1"
pkg_dirname="$_distname-$pkg_version"
pkg_deps=(
  core/musl
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  export CC=musl-gcc
  build_line "Setting CC=$CC"
}

do_build() {
  ./configure --host=arm
  make
}

do_check() {
  make check
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
    core/sed
    core/diffutils
    core/make
  )
fi
