pkg_name=dotnet-core
pkg_origin=core
pkg_version=1.0.0-preview3-003930
pkg_license=('MIT')
pkg_upstream_url=https://www.microsoft.com/net/core
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$pkg_version/dotnet-dev-debian-x64.$pkg_version.tar.gz"
pkg_shasum=67f88e6b3973435b43d7f4b615faf7c44f311debbab9139c38043cd19c0e5f76
pkg_filename="dotnet-debian-x64.$pkg_version.tar.gz"
pkg_deps=(
  core/curl
  core/gcc-libs
  core/glibc
  core/icu/52.1
  core/krb5
  core/libunwind
  core/lttng-ust
  core/openssl
  core/util-linux
  core/zlib
)
pkg_build_deps=(
  core/patchelf
)
pkg_bin_dirs=(bin)

do_unpack() {
  # Extract into $pkg_dirname instead of straight into $HAB_CACHE_SRC_PATH.
  mkdir -p "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  tar xfz "$HAB_CACHE_SRC_PATH/$pkg_filename" -C "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_prepare() {
  find -type f -name 'dotnet' \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "$LD_RUN_PATH" {} \;
  find -type f -name '*.so*' \
    -exec patchelf --set-rpath "$LD_RUN_PATH" {} \;
}

do_build() {
  return 0
}

do_install() {
  cp -a . "$pkg_prefix/bin"
}

do_check() {
  mkdir dotnet-new
  pushd dotnet-new
  ../dotnet new
  popd
  rm -rf dotnet-new
}

do_strip() {
  return 0
}
