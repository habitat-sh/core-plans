pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_name=jruby
pkg_version=9.4.12.0
pkg_description="A high performance, stable, fully threaded Java implementation of the Ruby programming language."
pkg_upstream_url=https://github.com/jruby/jruby
pkg_source="https://github.com/jruby/jruby/archive/${pkg_version}.tar.gz"
pkg_shasum=3379dc74d3c9d85bfb53aba0882e446aadde1de5c9ee75403beaea4fbb508625
pkg_license=('EPL 1.0, GPL 2 and LGPL 2.1')
pkg_deps=(core/glibc core/corretto11 core/bash core/coreutils)
pkg_build_deps=(core/which core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  export JAVA_HOME
  JAVA_HOME="$(pkg_path_for core/corretto11)"
  ./mvnw
}

do_install() {
  cp -R ./* "${pkg_prefix}/"
  # Remove *.so for other platforms...they cause `do_strip()' to fail
  rm -rf ${pkg_prefix}/lib/ruby/stdlib/libfixposix/binary/armv7-linux/libfixposix.so
  rm -rf ${pkg_prefix}/lib/ruby/stdlib/libfixposix/binary/armv6-linux/libfixposix.so
  rm -rf ${pkg_prefix}/lib/ruby/stdlib/libfixposix/binary/arm64-linux/libfixposix.so
  rm -rf ${pkg_prefix}/lib/target/classes/META-INF/jruby.home/lib/ruby/stdlib/libfixposix/binary/armv7-linux/libfixposix.so
  rm -rf ${pkg_prefix}/lib/target/classes/META-INF/jruby.home/lib/ruby/stdlib/libfixposix/binary/armv6-linux/libfixposix.so
  rm -rf ${pkg_prefix}/lib/target/classes/META-INF/jruby.home/lib/ruby/stdlib/libfixposix/binary/arm64-linux/libfixposix.so
  rm -rf ${pkg_prefix}/lib/target/rubygems/gems/ffi-binary-libfixposix-0.5.1.1-java/lib/libfixposix/binary/armv7-linux/libfixposix.so
  rm -rf ${pkg_prefix}/lib/target/rubygems/gems/ffi-binary-libfixposix-0.5.1.1-java/lib/libfixposix/binary/armv6-linux/libfixposix.so
  rm -rf ${pkg_prefix}/lib/target/rubygems/gems/ffi-binary-libfixposix-0.5.1.1-java/lib/libfixposix/binary/arm64-linux/libfixposix.so


  # shellcheck disable=SC2231
  for binstub in ${pkg_prefix}/bin/*; do
    [[ -f ${binstub} ]] && sed -e "s#/usr/bin/env bash#$(pkg_path_for bash)/bin/bash#" -i "${binstub}"
    [[ -f ${binstub} ]] && sed -e "s#/usr/bin/env jruby#${pkg_prefix}/bin/jruby#" -i "${binstub}"
  done

  # Remove *.so for other platforms...they cause `do_strip()' to fail
  # with `Unable to recognise the format' errors
  find "${pkg_prefix}/lib/jni/" -maxdepth 1 -mindepth 1 -type d -not -name "x86_64-Linux" -exec rm -rf "{}" \;
}
