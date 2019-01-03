pkg_name=gperftools
pkg_origin=core
pkg_version=2.7
pkg_description="Google Performance Tools"
pkg_upstream_url=https://github.com/gperftools/gperftools
pkg_license=('BSDv3')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/gperftools/gperftools/releases/download/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=1ee8c8699a0eff6b6a203e59b43330536b22bbcbe6448f54c7091e5efb0763c9
pkg_build_deps=(
  core/automake
  core/gcc
  core/make
)
pkg_deps=(
  core/binutils
  core/coreutils
  core/gcc-libs
  core/glibc
  core/grep
  core/graphviz
  core/perl
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  do_default_build

  fix_interpreter "src/pprof" core/coreutils bin/env
  sed -e "s#\"objdump\",#\"$(pkg_path_for core/binutils)/bin/objdump\",#" \
      -e "s#\"nm\",#\"$(pkg_path_for core/binutils)/bin/nm\",#" \
      -e "s#\"addr2line\",#\"$(pkg_path_for core/binutils)/bin/addr2line\",#" \
      -e "s#\"c++filt\",#\"$(pkg_path_for core/binutils)/bin/c++filt\",#" \
      -e "s#ShellEscape(\"grep\"#ShellEscape(\"$(pkg_path_for core/grep)/bin/grep\"#" \
      -e "s#ShellEscape(\"tail\"#ShellEscape(\"$(pkg_path_for core/coreutils)/bin/tail\"#" \
      -e "s#(\"dot\")#(\"$(pkg_path_for core/graphviz)/bin/dot\")#" \
      -i "src/pprof"
}

do_install() {
  do_default_install
  fix_interpreter "$pkg_prefix/bin/pprof" core/coreutils bin/env
}
do_check() {
  make check
}
