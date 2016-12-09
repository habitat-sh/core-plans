pkg_origin=core
pkg_name=logstash
pkg_version=5.0.2
pkg_description="Logstash is an open source, server-side data processing pipeline that ingests data from a multitude of sources simultaneously, transforms it, and then sends it to your favorite 'stash.'"
pkg_upstream_url=https://github.com/elastic/logstash
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(Apache-2.0)
pkg_source=https://artifacts.elastic.co/downloads/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=eff45f965118b6ef767f719d85f6dbca438ea2daa5e901907a32fa5bf1a70d9c
pkg_deps=(core/bash core/jre8 core/jruby1)
pkg_build_deps=(core/bash)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
  return 0
}

do_install() {
  mkdir -p "$pkg_prefix"
  cp -r ./* "$pkg_prefix"
  # The `config/' directory is special in Habitat so we'll just move
  # the various config files that ship with Logstash into `settings'
  # as Logstash refers to this location as SETTINGS_DIR.
  mv "$pkg_prefix/config" "$pkg_prefix/settings"
  rm -rf "$pkg_prefix/data"
  rm -rf "$pkg_prefix/vendor/jruby"
  fix_interpreter "${pkg_prefix}/bin/*" core/bash bin/sh

  # Ensure we only print to the console
  cp "${PLAN_CONTEXT}/log4j2.properties" "$pkg_prefix/settings/"
}
