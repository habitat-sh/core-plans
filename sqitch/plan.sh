pkg_name=sqitch
pkg_version=0.9994
pkg_origin=core
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Sqitch is a database change management application."
pkg_upstream_url=http://sqitch.org/
pkg_source=https://cpan.metacpan.org/authors/id/D/DW/DWHEELER/App-Sqitch-${pkg_version}.tar.gz
pkg_filename=App-Sqitch-${pkg_version}.tar.gz
pkg_dirname=App-Sqitch-${pkg_version}
pkg_shasum=24de7770884419f199d24fa2ce81f5e7a27583028f685e6973a06840be00c646
pkg_deps=(core/glibc core/perl core/cpanminus)
pkg_build_deps=(core/gcc core/make core/coreutils core/perl core/cpanminus)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_prepare() {
  cpanm Module::Build
}

do_build() {
  perl Build.PL
}

do_install() {
  export PERL_MM_USE_DEFAULT=1
  ./Build installdeps --cpan_client 'cpanm -v --notest' --defaultdeps
  ./Build
  ./Build install
}

do_check() {
  ./Build test
}
