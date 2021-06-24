pkg_name=mksh
pkg_origin=core
pkg_version="R59c"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MirOS" "ISC" "BSD-3-Clause")
pkg_source="https://www.mirbsd.org/MirOS/dist/mir/mksh/$pkg_name-$pkg_version.tgz"
pkg_shasum="77ae1665a337f1c48c61d6b961db3e52119b38e58884d1c89684af31f87bc506"
pkg_dirname="mksh"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc core/gawk core/wget)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/ksh bin/mksh)
pkg_description="The MirBSD Korn Shell"
pkg_upstream_url="http://www.mirbsd.org/mksh.htm"

do_build() {
  sh Build.sh -r
}

# shellcheck disable=SC2164
do_install() {
  install -D -m 755 mksh "${pkg_prefix}/bin/mksh"
  pushd "${pkg_prefix}/bin" >/dev/null
  ln -s mksh ksh >/dev/null
  popd

  mkdir -p "${pkg_prefix}/share"
  wget https://www.mirbsd.org/TaC-mksh.txt -O "${pkg_prefix}/share/TaC-mksh.txt"
}
