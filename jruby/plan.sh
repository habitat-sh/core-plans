pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_name=jruby
pkg_version=9.1.2.0
pkg_description="A high performance, stable, fully threaded Java implementation of the Ruby programming language."
pkg_upstream_url=https://github.com/jruby/jruby
pkg_source=https://github.com/jruby/jruby/archive/${pkg_version}.tar.gz
pkg_shasum=0653363e7fd87458205603d1b2c46bb87f051de0357290096fde7d6132339cbc
pkg_license=('EPL 1.0, GPL 2 and LGPL 2.1')
pkg_deps=(core/glibc core/jre8 core/bash)
pkg_build_deps=(core/which core/make core/jdk8 core/coreutils)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  export JAVA_HOME
  JAVA_HOME=$(pkg_path_for core/jdk8)
  ./mvnw
}

do_install() {
  cp -R ./* "$pkg_prefix/"
  for binstub in ${pkg_prefix}/bin/*; do
    [[ -f $binstub ]] && sed -e "s#/usr/bin/env bash#$(pkg_path_for bash)/bin/bash#" -i "$binstub"
    [[ -f $binstub ]] && sed -e "s#/usr/bin/env jruby#${pkg_prefix}/bin/jruby#" -i "$binstub"
  done

  # Remove *.so for other platforms...they cause `do_strip()' to fail
  # with `Unable to recognise the format' errors
  find "$pkg_prefix/lib/jni/" -maxdepth 1 -mindepth 1 -type d -not -name "x86_64-Linux" -exec rm -rf "{}" \;
}
