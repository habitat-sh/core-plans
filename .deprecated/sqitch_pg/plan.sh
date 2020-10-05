pkg_name=sqitch_pg
pkg_origin=core
pkg_version="3.7.4"
pkg_maintainer="The Habitat Maintainers humans@habitat.sh"
pkg_license=('Artistic-1.0-Perl' 'GPL-2.0')
pkg_deps=(
  core/glibc
  core/perl
  core/postgresql-client
  core/zlib
  core/sqitch
)
pkg_build_deps=(
  core/cpanminus
  core/local-lib
  core/gcc
  core/make
)
pkg_description="Sqitch the database management application, bundled with the DBD::Pg Perl module for PostgreSQL"
pkg_upstream_url="http://sqitch.org/" # Note: also http://search.cpan.org/dist/DBD-Pg/
pkg_bin_dirs=(bin)

do_setup_environment() {
  push_runtime_env PERL5LIB "${pkg_prefix}/lib/perl5/x86_64-linux-thread-multi"
}

do_build() {
  return 0
}

do_install() {
  source <(perl -I"$(pkg_path_for core/local-lib)/lib/perl5" -Mlocal::lib="$(pkg_path_for core/local-lib)")
  source <(perl -I"$(pkg_path_for core/cpanminus)/lib/perl5" -Mlocal::lib="$(pkg_path_for core/cpanminus)")
  source <(perl -Mlocal::lib="$pkg_prefix")
  cpanm "DBD::Pg@$pkg_version" --local-lib "$pkg_prefix"
}
