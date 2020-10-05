pkg_name=local-lib
pkg_version=2.000019
pkg_origin=core
pkg_license=('Artistic-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="create and use a local lib/ for perl modules with PERL5LIB"
pkg_upstream_url='https://github.com/Perl-Toolchain-Gang/local-lib'
pkg_source=http://search.cpan.org/CPAN/authors/id/H/HA/HAARG/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-${pkg_version}
pkg_shasum=36ad327a099667b8cb292c10229c33849c787470e0b978e4963b69b6df4c0b01
pkg_deps=(core/glibc core/perl)
pkg_build_deps=(core/gcc core/make core/coreutils core/perl)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
  perl Makefile.PL --bootstrap=${pkg_prefix} --no-manpages
}
