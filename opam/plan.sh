pkg_name=opam
pkg_origin=core
pkg_description="opam is a source-based package manager. It supports multiple simultaneous compiler installations, flexible package constraints, and a Git-friendly development workflow."
pkg_upstream_url="https://opam.ocaml.org/"
pkg_version="1.2.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/opam/releases/download/${pkg_version}/opam-full-${pkg_version}.tar.gz"
pkg_shasum="15e617179251041f4bf3910257bbb8398db987d863dd3cfc288bdd958de58f00"
pkg_dirname="opam-full-${pkg_version}"
pkg_deps=(
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
  ./configure --prefix "${pkg_prefix}"
  make lib-ext
  make
}

do_strip() {
  return 0
}
