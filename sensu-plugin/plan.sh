pkg_name=sensu-plugin
pkg_origin=core
pkg_version=1.4.3
pkg_source=https://github.com/${pkg_name}s/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=5c68eb477f333b6fc9fa26829323d401d17addc0d44068b0267683bff9b3197a
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A framework for writing Sensu plugins & handlers with Ruby."
pkg_upstream_url=https://sensuapp.org
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_license=('MIT')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_deps=(core/ruby core/bundler core/coreutils core/gcc-libs)
pkg_build_deps=(core/gcc core/make)
pkg_svc_user=root
pkg_svc_group=${pkg_svc_user}

do_build() {
  local _bundler_dir
  _bundler_dir=$(pkg_path_for bundler)
  export GEM_HOME=${pkg_path}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}

  bundle install --jobs 2 --retry 5 --path ./vendor/bundle --binstubs
}

do_install() {
  cp -R . "$pkg_prefix/"
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}
