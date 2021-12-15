pkg_name=dotnet-core-sdk
pkg_origin=core
pkg_version=3.1.416
pkg_license=('MIT')
pkg_upstream_url=https://www.microsoft.com/net/core
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://download.visualstudio.microsoft.com/download/pr/3c98126b-50f5-4497-8ffd-18d17a3f6b95/044d0f20256fd9bf2971f8da9a0364e4/dotnet-sdk-${pkg_version}-linux-x64.tar.gz"
pkg_shasum=5152c88b9fb540b2e6af0fb025ba33ac2c9bc2c91d7758ea2adb26fd54e1480e
pkg_filename="dotnet-dev-debian-x64.${pkg_version}.tar.gz"
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
  tar xf "$HAB_CACHE_SRC_PATH/$pkg_filename" \
    -C "$HAB_CACHE_SRC_PATH/$pkg_dirname" \
    --no-same-owner
}

do_prepare() {
  find . -type f -name 'dotnet' \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "$LD_RUN_PATH" {} \;
  find . -type f -name '*.so*' \
    -exec patchelf --set-rpath "$LD_RUN_PATH" {} \;
  fix_interpreter "$HAB_CACHE_SRC_PATH/$pkg_dirname/sdk/${pkg_version}/Roslyn/RunCsc.sh" core/coreutils bin/env
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
