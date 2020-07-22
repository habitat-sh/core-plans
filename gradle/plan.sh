pkg_name=gradle
pkg_origin=core
pkg_version=5.6.4
pkg_source="https://services.gradle.org/distributions/${pkg_name}-${pkg_version}-bin.zip"
pkg_shasum=1f3067073041bc44554d0efe5d402a33bc3d3c93cc39ab684f308586d732a80d
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_build_deps=(
  core/make
  core/gcc
  core/patchelf
)
pkg_deps=(
  core/glibc
  core/openjdk11
  core/coreutils
  core/bash-static
  core/gcc-libs
  core/sed
)

do_build() {
  local native_platform_version=0.18
  mkdir patching
  pushd patching
  jar xf "../lib/native-platform-linux-amd64-${native_platform_version}.jar"
  patchelf --set-rpath "${LD_RUN_PATH}" net/rubygrapefruit/platform/linux-amd64/libnative-platform.so
  jar cf "native-platform-linux-amd64-${native_platform_version}.jar" .
  mv "native-platform-linux-amd64-${native_platform_version}.jar" ../lib/
  popd
  rm -rf patching
  fix_interpreter bin/gradle core/coreutils bin/env
}

do_install() {
  cp -vr . "${pkg_prefix}"
}

do_strip() {
  return 0
}
