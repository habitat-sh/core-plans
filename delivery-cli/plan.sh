pkg_name=delivery-cli
pkg_origin=core
pkg_version=0.0.35
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source=https://github.com/chef/delivery-cli/archive/${pkg_version}.tar.gz
pkg_shasum=a0d8eb0a50964a72742c4f160d3db0f67b9922f26eca84b4f98e643ff0d0cfe8
pkg_deps=(core/gcc core/libarchive core/openssl)
pkg_build_deps=(core/rust core/cacerts core/zlib)
pkg_bin_dirs=(bin)
program=delivery

do_prepare() {
  # Used by Cargo to fetch registries/crates/etc.
  export SSL_CERT_FILE="$(pkg_path_for cacerts)/ssl/cert.pem"
  build_line "Setting SSL_CERT_FILE=$SSL_CERT_FILE"

  # Used to find libgcc_s.so.1 when compiling `build.rs` in dependencies. Since
  # this used only at build time, we will use the version found in the gcc
  # package proper--it won't find its way into the final binaries.
  export LD_LIBRARY_PATH="$(pkg_path_for gcc)/lib"
  build_line "Setting LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

  la_ldflags="-L$(pkg_path_for zlib)/lib -lz"
  la_ldflags="$la_ldflags -L$(pkg_path_for openssl)/lib -lssl -lcrypto"

  export LIBARCHIVE_LIB_DIR="$(pkg_path_for libarchive)/lib"
  export LIBARCHIVE_INCLUDE_DIR="$(pkg_path_for libarchive)/include"
  export LIBARCHIVE_LDFLAGS="$la_ldflags"
  export OPENSSL_LIB_DIR="$(pkg_path_for openssl)/lib"
  export OPENSSL_INCLUDE_DIR="$(pkg_path_for openssl)/include"

  export DELIV_CLI_VERSION=${pkg_version}
  export DELIV_CLI_GIT_SHA=444effdf9c81908795e88157f01cd667a6c43b5f
}

do_build() {
  cargo clean --verbose
  cargo build  -j $(nproc) --release --verbose
}

do_install() {
  install -v -D $HAB_CACHE_SRC_PATH/$pkg_dirname/target/release/$program \
    $pkg_prefix/bin/$program
}

do_strip() {
  strip $pkg_prefix/bin/$program
}
