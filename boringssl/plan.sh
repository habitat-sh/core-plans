pkg_name=boringssl
pkg_origin=core
pkg_description="BoringSSL is a fork of OpenSSL that is designed to meet Google\'s needs."
pkg_upstream_url='https://boringssl.googlesource.com/boringssl/'
pkg_version=3945
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('OpenSSL ISC')
pkg_source="https://boringssl.googlesource.com/boringssl/+archive/refs/heads/chromium-${pkg_version}.tar.gz"
pkg_shasum="None"
pkg_deps=(
  core/glibc
  core/gcc-libs
)

pkg_build_deps=(
  core/go
  core/perl
  core/ninja
  core/cmake
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_unpack() {
  mkdir -p "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  tar xf "${HAB_CACHE_SRC_PATH}/${pkg_filename}" \
    -C "${HAB_CACHE_SRC_PATH}/${pkg_dirname}" \
    --no-same-owner
}

# This feels bad but Google doesn't do releases and that branch is a moving target
do_verify() {
  return 0
}

do_build() {
  mkdir -p "build"
  pushd build >/dev/null
  cmake ..
  make
  popd >/dev/null
}

do_install() {
  pushd build >/dev/null
  mkdir -p "${pkg_prefix}/bin" "${pkg_prefix}/include" "${pkg_prefix}/lib"
  mv tool/bssl "${pkg_prefix}/bin"
  mv ssl/libssl.a           "${pkg_prefix}/lib"
  mv crypto/libcrypto.a     "${pkg_prefix}/lib"
  mv decrepit/libdecrepit.a "${pkg_prefix}/lib"
  mv ../include/openssl "${pkg_prefix}/include"
  popd >/dev/null
}
