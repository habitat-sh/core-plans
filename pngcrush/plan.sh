pkg_name=pngcrush
pkg_origin=core
pkg_version="1.8.13"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://downloads.sourceforge.net/project/pmt/${pkg_name}/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="8fc18bcbcc65146769241e20f9e21e443b0f4538d581250dce89b1e969a30705"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_description="Pngcrush is an optimizer for PNG (Portable Network Graphics) files."
pkg_upstream_url="https://pmt.sourceforge.io/pngcrush/"

do_build() {
  make
}

do_install() {
  install -Dm0755 pngcrush "${pkg_prefix}/bin/pngcrush"
  install -Dm0644 LICENSE "${pkg_prefix}/share/LICENSE"
}
