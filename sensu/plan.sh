pkg_name=sensu
pkg_origin=core
pkg_version=0.26.5
pkg_source=http://nothing.to.download.from.com
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A monitoring framework that aims to be simple, malleable, and scalable."
pkg_upstream_url=https://sensuapp.org
pkg_license=('MIT')

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

pkg_svc_user=root
pkg_svc_group=${pkg_svc_user}

pkg_build_deps=(core/make core/gcc core/gcc-libs)
pkg_deps=(core/ruby core/bundler core/coreutils)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  mkdir -p "/hab/cache/src/${pkg_name}-${pkg_version}"
  cp -f ./Gemfile "/hab/cache/src/${pkg_name}-${pkg_version}/Gemfile"
}

do_install() {
  cp -R . "$pkg_prefix/"
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}


do_build() {
  local _bundler_dir
  _bundler_dir=$(pkg_path_for bundler)

  export GEM_HOME=${pkg_path}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}
  bundle install --jobs 2 --retry 5 --path ./vendor/bundle --binstubs
}
