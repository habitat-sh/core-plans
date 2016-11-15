pkg_name=ruby-rails-sample
pkg_version=0.0.1
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('mit')
pkg_source=https://github.com/jtimberman/ruby-rails-sample/archive/${pkg_version}.tar.gz
pkg_shasum=a4a6daf4c2637d37800de9b083d22d79367cd00ee9702478cdaff72f7d97dd75

pkg_deps=(
  core/bundler
  core/cacerts
  core/glibc
  core/libffi
  core/libxml2
  core/libxslt
  core/libyaml
  core/node
  core/openssl
  core/postgresql
  core/ruby
  core/zlib
)

pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_expose=(3000)

do_build() {
  export CPPFLAGS="${CPPFLAGS} ${CFLAGS}"

  local _bundler_dir
  local _libxml2_dir
  local _libxslt_dir
  local _postgresql_dir
  local _pgconfig
  local _zlib_dir

  _bunlder_dir="$(pkg_path_for bundler)"
  _libxml2_dir="$(pkg_path_for libxml2)"
  _libxslt_dir="$(pkg_path_for libxslt)"
  _postgresql_dir=$(pkg_path_for postgresql)
  _pgconfig="${_postgresql_dir}/bin/pg_config"
  _zlib_dir="$(pkg_path_for zlib)"

  export GEM_HOME="${pkg_path}/vendor/bundle"
  export GEM_PATH="${_bundler_dir}:${GEM_HOME}"

  # don't let bundler split up the nokogiri config string (it breaks
  # the build), so specify it as an env var instead
  export NOKOGIRI_CONFIG="--use-system-libraries --with-zlib-dir=${_zlib_dir} --with-xslt-dir=${_libxslt_dir} --with-xml2-include=${_libxml2_dir}/include/libxml2 --with-xml2-lib=${_libxml2_dir}/lib"
  bundle config build.nokogiri "${NOKOGIRI_CONFIG}"
  bundle config build.pg --with-pg-config="${_pgconfig}"

  # We need to add tzinfo-data to the Gemfile since we're not in an
  # environment that has this from the OS
  if ! grep 'gem .*tzinfo-data.*' Gemfile; then
    echo 'gem "tzinfo-data"' >> Gemfile
  fi

  # Remove the specific ruby version, because our ruby is 2.3
  sed -e 's/^ruby.*//' -i Gemfile

  bundle install --jobs 2 --retry 5 --path vendor/bundle --binstubs
}

do_install() {
  cp -R . "${pkg_prefix}/dist"

  for binstub in ${pkg_prefix}/dist/bin/*; do
    build_line "Setting shebang for ${binstub} to 'ruby'"
    [[ -f $binstub ]] && sed -e "s#/usr/bin/env ruby#$(pkg_path_for ruby)/bin/ruby#" -i "$binstub"
  done
}
