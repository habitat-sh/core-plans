pkg_name=opam
pkg_origin=core
pkg_description="opam is a source-based package manager. It supports multiple simultaneous compiler installations, flexible package constraints, and a Git-friendly development workflow."
pkg_upstream_url="https://opam.ocaml.org/"
pkg_version="2.4.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/opam/releases/download/${pkg_version}/opam-full-${pkg_version}.tar.gz"
pkg_shasum="119f41efb1192dad35f447fbf1c6202ffc331105e949d2980a75df8cb2c93282"
pkg_dirname="opam-full-${pkg_version}"
pkg_deps=(
  core/aspcud
  core/camlp4
  core/diffutils
  core/gcc
  core/git
  core/glibc
  core/m4
  core/make
  core/patch
  core/pkg-config
  core/rsync
  core/ocaml
  core/ocamlbuild
  core/which
)

pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix "${pkg_prefix}" --with-vendored-deps
  make
}

do_strip() {
  return 0
}
