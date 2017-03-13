pkg_name=dotnet-core-sdk
pkg_origin=core
pkg_version=1.0.1
pkg_license=('MIT')
pkg_upstream_url=https://www.microsoft.com/net/core
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://download.microsoft.com/download/F/D/5/FD52A2F7-65B6-4912-AEDD-4015DF6D8D22/dotnet-1.1.1-sdk-debian-x64.tar.gz"
pkg_shasum=84601397f83adaf2028653b73f27093f66d4c763dae5c770743351975477ee1e
pkg_filename="dotnet-1.1.1-sdk-debian-x64.tar.gz"
pkg_deps=(
  core/coreutils
  core/curl
  core/gcc-libs
  core/glibc
  core/icu52
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
  fix_interpreter "$HAB_CACHE_SRC_PATH/$pkg_dirname/sdk/1.0.1/Roslyn/RunCsc.sh" core/coreutils bin/env
}

do_build() {
  return 0
}

do_install() {
  cp -a . "$pkg_prefix/bin"
  chmod o+r -R "$pkg_prefix/bin"
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
