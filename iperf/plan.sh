pkg_name=iperf
pkg_origin=core
pkg_version=3.1.3
pkg_description="iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks."
pkg_upstream_url="https://iperf.fr/"
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://iperf.fr/download/source/iperf-${pkg_version}-source.tar.gz"
pkg_shasum=e34cf60cffc80aa1322d2c3a9b81e662c2576d2b03e53ddf1079615634e6f553
# core/coreutils isn't /really/ needed at runtime, but fix_interpreter
# only works if the dep is listed in pkg_deps
pkg_deps=(
  core/coreutils
  core/glibc
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix="${pkg_prefix}"
  make -j "$(nproc)"
}

do_check() {
  fix_interpreter "tests/TESTonce" core/coreutils bin/env
  make check
}

do_install() {
  do_default_install
  ln -s "${pkg_prefix}/bin/iperf3" "${pkg_prefix}/bin/iperf"
}
