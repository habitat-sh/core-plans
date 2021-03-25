pkg_name=gperftools
pkg_origin=core
pkg_version=2.9.1
pkg_description="Google Performance Tools"
pkg_upstream_url=https://github.com/gperftools/gperftools
pkg_license=('BSDv3')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/gperftools/gperftools/releases/download/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=0f59a4dcdb3f64e9ff5ea760731089de5872ef70f506afc537d48995a090c2b1
pkg_build_deps=(
  core/gcc
  core/make
  core/automake
)
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/graphviz
  core/coreutils
  core/grep
  core/perl
  core/binutils
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

do_check() {
  make check
}
