pkg_name=intltool
pkg_origin=core
pkg_version="0.51.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPLv2')
pkg_description="intltool is a set of tools to centralize translation of many different file formats using GNU gettext-compatible PO files."
pkg_upstream_url="https://freedesktop.org/wiki/Software/intltool/"
pkg_source="https://launchpad.net/intltool/trunk/0.51.0/+download/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc core/patch core/perl core/local-lib core/cpanminus core/expat)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_prepare() {
  eval "$(perl -I"$(pkg_path_for core/local-lib)/lib/perl5" -Mlocal::lib="$(pkg_path_for core/local-lib)")"
  eval "$(perl -Mlocal::lib="${pkg_prefix}/lib")"
  cpanm XML::Parser --configure-args="EXPATLIBPATH=$(pkg_path_for core/expat)/lib export EXPATINCPATH=$(pkg_path_for core/expat)/include"
  # make intltool work with perl 5.26+
  patch intltool-update.in "${PLAN_CONTEXT}/intltool-0.51.0-perl-5.26.patch"
}

do_install() {
  do_default_install
}
