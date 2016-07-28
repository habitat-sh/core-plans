pkg_name=dotnet-core
pkg_origin=core
pkg_version=1.0.0-preview2-003121
pkg_license=('Microsoft .NET Library')
pkg_upstream_url=https://www.microsoft.com/net/core
pkg_description=".NET Core is a blazing fast, lightweight and modular platform
  for creating web applications and services that run on Windows,
  Linux and Mac."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://download.microsoft.com/download/1/5/2/1523EBE1-3764-4328-8961-D1BD8ECA9295/dotnet-dev-debian-x64.$pkg_version.tar.gz"
pkg_shasum=204ceab7bc92c17d17691b0d5c1d54992fc78a969fc217a8423045875a4c63ed
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
  mkdir -p "$pkg_dirname"
  tar xfz "$pkg_filename" -C "$pkg_dirname"
}

do_prepare() {
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    --set-rpath "$LD_RUN_PATH" \
    ./dotnet
}

do_build() {
  return 0
}

do_install() {
  # Copy the files into the package
  cp -a . "$pkg_prefix"

  # Wrap the binary in a script that sets the library paths
  mkdir -p "$pkg_prefix/bin"
  cat > "$pkg_prefix/bin/dotnet" <<EOF
#!/bin/sh
export LD_LIBRARY_PATH="$pkg_prefix/lib:$LD_RUN_PATH:\$LD_LIBRARY_PATH"
exec $pkg_prefix/dotnet \$@
EOF
  chmod +x "$pkg_prefix/bin/dotnet"
}
