pkg_name=fping
pkg_origin=core
pkg_version="4.4"
pkg_description="$(cat << EOF
  fping is a program to send ICMP echo probes to network hosts, similar to
  ping, but much better performing when pinging multiple hosts. fping has a
  long long story: Roland Schemers did publish a first version of it in 1992
  and it has established itself since then as a standard tool.
EOF
)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('custom')
pkg_source="https://github.com/schweikert/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=538ef95e4c1cdb488339e91f21d4eb8542aec7ee8dcc9cdbce6eb680a1ddd090
pkg_upstream_url="http://fping.org/"
pkg_build_deps=(
  core/autoconf
  core/autogen
  core/automake
  core/gcc
  core/iana-etc
  core/make
)
pkg_deps=(core/glibc)
pkg_bin_dirs=(sbin)

do_build() {
  ./autogen.sh
  do_default_build
}

do_check() {
  make check
}

do_install() {
  do_default_install
  install -Dm644 COPYING "${pkg_prefix}/share/licenses/license.txt"
}
