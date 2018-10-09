pkg_name=dotnet-core-sdk
pkg_origin=core
pkg_version=2.1.403
pkg_license=('MIT')
pkg_upstream_url=https://www.microsoft.com/net/core
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://download.visualstudio.microsoft.com/download/pr/e85de743-f80b-481b-b10e-d2e37f05a7ce/0bf3ff93417e19ad8d6b2d3ded84d664/dotnet-sdk-${pkg_version}-linux-x64.tar.gz"
pkg_shasum=0bc7b42450a6a35f83aa6a7dfdc9cf39f3e1c7488dc1cc085b2f2a84207a3fc5
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
