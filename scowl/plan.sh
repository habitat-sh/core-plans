pkg_name=scowl
pkg_origin=core
pkg_version=2017.08.24
pkg_description="Spell Checking Oriented Word Lists (SCOWL)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source=http://downloads.sourceforge.net/wordlist/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ba84da9f5af06dbfded82236372545c06fd8162c3d48d11410bdfcf27ef3b0cd
pkg_upstream_url=http://wordlist.aspell.net/

do_build() {
  return 0
}

do_install() {
  mkdir -p "$pkg_prefix/share/dict"
  install -m444 -t "$pkg_prefix/share/dict" -v final/*
}
