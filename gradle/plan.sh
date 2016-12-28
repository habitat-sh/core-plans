pkg_name=gradle
pkg_origin=core
pkg_version=3.2.1
pkg_source=https://services.gradle.org/distributions/${pkg_name}-${pkg_version}-bin.zip
pkg_shasum=9843a3654d3e57dce54db06d05f18b664b95c22bf90c6becccb61fc63ce60689
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_build_deps=(core/make core/gcc core/jdk8 core/patchelf)
pkg_deps=(core/glibc core/jre8 core/coreutils core/bash-static core/gcc-libs core/sed)

do_build() {
  mkdir patching
  pushd patching
  jar xf ../lib/native-platform-linux-amd64-0.11.jar
  patchelf --set-rpath "${LD_RUN_PATH}" net/rubygrapefruit/platform/linux-amd64/libnative-platform.so
  jar cf native-platform-linux-amd64-0.11.jar .
  mv native-platform-linux-amd64-0.11.jar ../lib/
  popd
  rm -rf patching
  fix_interpreter bin/gradle core/coreutils bin/env
}

do_install() {
  cp -vr . "$pkg_prefix"
}

do_strip() {
  return 0
}
