pkg_name=sensu
pkg_origin=core
pkg_version=1.6.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A monitoring framework that aims to be simple, malleable, and scalable."
pkg_upstream_url="https://sensuapp.org"
pkg_license=('MIT')
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=${pkg_svc_user}
pkg_build_deps=(
  core/gcc-libs
  core/libffi
  core/make
  core/openssl
)
pkg_deps=(
  core/bundler
  core/coreutils
  core/gcc
  core/ruby
)
pkg_binds_optional=(
  [rabbitmq]="port"
  [redis]="port"
)
pkg_exports=(
  [port]=api.port
)
pkg_exposes=(port)

do_unpack() {
  mkdir -p "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  cp -f ./Gemfile "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/Gemfile"
}

do_prepare() {
  local _bundler_dir
  _bundler_dir=$(pkg_path_for bundler)

  export GEM_HOME=${pkg_prefix}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}
  build_line "Setting GEM_HOME=${GEM_HOME}"
  build_line "Setting GEM_PATH=${GEM_PATH}"

  # Bundler/gem seems to set the rpath for compiled extensions using LD_RUN_PATH.
  # Dynamic linking fails if this is not set
  LD_RUN_PATH="$(pkg_path_for gcc-libs)/lib:$(pkg_path_for libffi)/lib:$(pkg_path_for openssl)/lib:${LD_RUN_PATH}"
  export LD_RUN_PATH
  build_line "Setting LD_RUN_PATH=${LD_RUN_PATH}"
}

do_build() {
  pushd "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  bundle install --jobs 2 --retry 5 --path ./vendor/bundle --binstubs
  popd
}

do_install() {
  pushd "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  cp -R . "$pkg_prefix/"
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
  popd
}
