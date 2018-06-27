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
pkg_deps=(core/glibc core/perl core/local-lib core/cpanminus)
pkg_build_deps=(core/gcc core/make core/coreutils core/perl core/local-lib core/cpanminus)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_setup_environment() {
  push_runtime_env PERL5LIB "${pkg_prefix}/lib/perl5:${pkg_prefix}/lib/perl5/x86_64-linux-thread-multi"
}

do_prepare() {
  eval "$(perl -I"$(pkg_path_for core/local-lib)"/lib/perl5 -Mlocal::lib="$(pkg_path_for core/local-lib)")"
  # Create a new lib dir in our pacakge for cpanm to house all of its libs
  eval "$(perl -Mlocal::lib="${pkg_prefix}")"

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

  for file in "${pkg_prefix}"/bin/*; do
    sed -i "1 s,.*,& -I${pkg_prefix}/lib/perl5," "$file"
  done
}

do_check() {
  ./Build test
}
