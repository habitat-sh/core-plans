pkg_name=libsodium
_distname="$pkg_name"
pkg_origin=core
pkg_version=1.0.16
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Sodium is a new, easy-to-use software library for encryption, decryption, \
signatures, password hashing and more. It is a portable, cross-compilable, \
installable, packageable fork of NaCl, with a compatible API, and an extended \
API to improve usability even further.\
"
pkg_upstream_url="https://github.com/jedisct1/libsodium"
pkg_license=('ISC')
pkg_source="https://download.libsodium.org/libsodium/releases/${_distname}-${pkg_version}.tar.gz"
pkg_shasum="eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533"
pkg_dirname="${_distname}-${pkg_version}"
pkg_deps=(
  core/glibc
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

do_check() {
  make check
}
