pkg_name=sensu
pkg_origin=core
pkg_version=0.26.5
pkg_source=https://github.com/sensu/sensu/archive/v0.26.5.tar.gz
pkg_shasum=c3e41597d44431f510eeb0ff4fcf6567e9736cddd311647c121ebd751a4f963d
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A monitoring framework that aims to be simple, malleable, and scalable."
pkg_upstream_url=https://sensuapp.org
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_license=('MIT')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_deps=(
  core/libffi
  core/ruby
  core/bundler
  core/coreutils
  core/gcc-libs
  edavis/sensu-plugin
)
pkg_build_deps=(core/gcc core/make)
pkg_svc_user=root
pkg_svc_group=${pkg_svc_user}

do_build() {
  local _bundler_dir
  _bundler_dir=$(pkg_path_for bundler)
  GEM_HOME=${pkg_path}/vendor/bundle
  GEM_PATH=${_bundler_dir}:${GEM_HOME}

  bundle install --jobs 2 --retry 5 --path ./vendor/bundle --binstubs
}

do_install() {
  cp -R . "$pkg_prefix/"
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}
