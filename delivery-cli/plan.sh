pkg_name=delivery-cli
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=0.0.32
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source=https://github.com/chef/delivery-cli/archive/${pkg_version}.tar.gz
pkg_shasum=a89a6eba61492dd7c09e6ddae464bfebc696606cb3a255003ab0d36991130f27
pkg_deps=(
)
pkg_build_deps=(
  core/rust
  core/gcc
  core/cacerts
  core/libarchive
  core/zlib
  core/openssl
)
pkg_bin_dirs=(bin)

do_prepare() {
  # Used by Cargo to fetch registries/crates/etc.
  export SSL_CERT_FILE=$(pkg_path_for cacerts)/ssl/cert.pem
  build_line "Setting SSL_CERT_FILE=$SSL_CERT_FILE"

  # Used to find libgcc_s.so.1 when compiling `build.rs` in dependencies. Since
  # this used only at build time, we will use the version found in the gcc
  # package proper--it won't find its way into the final binaries.
  export LD_LIBRARY_PATH=$(pkg_path_for gcc)/lib
  build_line "Setting LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

  # If there are any build errors this may help
  export RUST_BACKTRACE=1

  la_ldflags="-L$(pkg_path_for zlib)/lib -lz"
  la_ldflags="$la_ldflags -L$(pkg_path_for openssl)/lib -lssl -lcrypto"

  export LIBARCHIVE_LIB_DIR=$(pkg_path_for libarchive)/lib
  export LIBARCHIVE_INCLUDE_DIR=$(pkg_path_for libarchive)/include
  export LIBARCHIVE_LDFLAGS="$la_ldflags"
  export LIBARCHIVE_STATIC=true
  export OPENSSL_LIB_DIR=$(pkg_path_for openssl)/lib
  export OPENSSL_INCLUDE_DIR=$(pkg_path_for openssl)/include
  export OPENSSL_STATIC=true

  export DELIV_CLI_VERSION=${pkg_version}
  # TODO
  # export DELIV_CLI_GIT_SHA=Omnibus::Fetcher.resolve_version(version, source)
  export DELIV_CLI_GIT_SHA=444effdf9c81908795e88157f01cd667a6c43b5f
}

do_build() {
  cargo clean --verbose
  cargo build  -j $(nproc) --release --verbose
}

do_install() {
  install -v -D $PLAN_CONTEXT/target/default/release/$program \
    $pkg_prefix/bin/$pkg_distname
}

do_strip() {
  strip $pkg_prefix/bin/$pkg_distname
}
