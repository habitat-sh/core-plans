source "$(dirname "${BASH_SOURCE[0]}")/../gradle/plan.sh"

pkg_name=gradle4
pkg_distname=gradle
pkg_origin=core
pkg_version=4.10.3
pkg_source=https://services.gradle.org/distributions/${pkg_distname}-${pkg_version}-bin.zip
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_shasum=8626cbf206b4e201ade7b87779090690447054bc93f052954c78480fa6ed186e
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')

native_platform_version="0.14"
do_build() {
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
