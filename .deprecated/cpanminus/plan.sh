pkg_name=cpanminus
pkg_version=1.7044
pkg_origin=core
pkg_license=('Artistic-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="cpanminus is a script to get, unpack, build and install modules from CPAN and does nothing else."
pkg_upstream_url=http://cpanmin.us
pkg_source=https://github.com/miyagawa/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-${pkg_version}
pkg_shasum=a5407a85c2f3dda74dfc2241c68dafb9951f2a6eeada0a0eea9e7238a482c195
pkg_build_deps=(
  core/coreutils
  core/curl
  core/gcc
  core/local-lib
  core/make
  core/perl
)
pkg_deps=(
  core/glibc
  core/local-lib
  core/perl
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  # Load local::lib into our current perl include chain
  eval "$(perl -I"$(pkg_path_for core/local-lib)"/lib/perl5 -Mlocal::lib="$(pkg_path_for core/local-lib)")"
  # Create a new lib dir in our pacakge for cpanm to house all of its libs
  eval "$(perl -Mlocal::lib="${pkg_prefix}")"

  # cpanm prioritizes the local::lib location for an install dir
  curl -L http://cpanmin.us | perl - App::cpanminus
}
