pkg_origin=core
pkg_name=logstash
pkg_version=6.3.1
pkg_description="Logstash is an open source, server-side data processing pipeline that ingests data from a multitude of sources simultaneously, transforms it, and then sends it to your favorite 'stash.'"
pkg_upstream_url=https://github.com/elastic/logstash
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(Apache-2.0)
pkg_source=https://artifacts.elastic.co/downloads/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=7ee85ea0b01c4ff3330402b070dda1e1238cde80fcf771b01ec1d1b4dc61160d
pkg_deps=(core/bash
  core/jre8
  core/coreutils
)
pkg_build_deps=(core/bash)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
  return 0
}

do_install() {
  mkdir -p "$pkg_prefix"
  cp -r ./* "$pkg_prefix"

  # Ensure default `data/queue' dir exists and is writable (even though
  # we override it in `hooks/run') to work around:
  #
  #   https://github.com/elastic/logstash/issues/6378
  #
  mkdir -p "$pkg_prefix/data/queue"
  chmod 0777 "$pkg_prefix/data" "$pkg_prefix/data/queue"

  # The `config/' directory is special in Habitat so we'll just move
  # the various config files that ship with Logstash into `settings'
  # as Logstash refers to this location as SETTINGS_DIR.
  mv "$pkg_prefix/config" "$pkg_prefix/settings"

  # Remove non x86_64-Linux vendored JNI native extensions or `strip' will
  # throw `Unable to recognise the format of the input file' errors
  find "$pkg_prefix/vendor/jruby/lib/jni/" -mindepth 1 -maxdepth 1 -type d -not -name 'x86_64-Linux' -exec rm -rf {} \;

  fix_interpreter "${pkg_prefix}/bin/*" core/bash bin/sh
  fix_interpreter "${pkg_prefix}/vendor/jruby/bin/*" core/coreutils bin/env

  # Ensure we only print to the console
  cp "${PLAN_CONTEXT}/log4j2.properties" "$pkg_prefix/settings/"
}
