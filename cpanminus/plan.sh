pkg_name=cpanminus
pkg_version=1.7040
pkg_origin=core
pkg_license=('Artistic-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="cpanminus is a script to get, unpack, build and install modules from CPAN and does nothing else."
pkg_upstream_url=http://cpanmin.us
pkg_source=https://github.com/miyagawa/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-${pkg_version}
pkg_shasum=48a747c040689445f7db0edd169da0abd709a37cfece3ceecff0816c09beab0e
pkg_deps=(core/glibc core/perl core/local-lib)
pkg_build_deps=(core/gcc core/make core/coreutils core/perl core/local-lib)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  # Load local::lib into our current perl include chain
  eval "$(perl -I$(pkg_path_for core/local-lib)/lib/perl5 -Mlocal::lib=$(pkg_path_for core/local-lib))"
  # Create a new lib dir in our pacakge for cpanm to house all of its libs
  eval $(perl -Mlocal::lib=${pkg_prefix})

  # cpanm prioritizes the local::lib location for an install dir
  cat cpanm | perl - App::cpanminus
}
