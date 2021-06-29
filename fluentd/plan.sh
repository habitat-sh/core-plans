pkg_name=fluentd
pkg_origin=core
pkg_version=1.12.1
pkg_deps=(
  core/ruby
  core/coreutils
  core/bundler
)
pkg_build_deps=(
  core/make
  core/gcc
  core/gcc-libs
)
pkg_upstream_url=https://www.fluentd.org/
pkg_description="Fluentd is an open source data collector, which lets \
  you unify the data collection and consumption for a better use and \
  understanding of data."
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=nothing-downloaded-but-build-in-src-cache-anyway
pkg_bin_dirs=(bin)
pkg_exports=(
  [forward-port]=input.forward.port
  [http-port]=input.http.port
)
pkg_exposes=(forward-port http-port)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  local _bundler_dir
  _bundler_dir=$(pkg_path_for bundler)

  export GEM_HOME=${pkg_path}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}

  cat > Gemfile <<-GEMFILE
    source 'https://rubygems.org'
    gem 'fluentd', '= ${pkg_version}'
GEMFILE

  bundle install --jobs 2 --retry 5 --path ./vendor/bundle --binstubs
}

do_install() {
  cp -R . "$pkg_prefix/"
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}
