pkg_name=opam
pkg_origin=core
pkg_description="opam is a source-based package manager. It supports multiple simultaneous compiler installations, flexible package constraints, and a Git-friendly development workflow."
pkg_upstream_url="https://opam.ocaml.org/"
pkg_version="1.3.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL')
pkg_source="https://github.com/ocaml/opam/releases/download/${pkg_version}/opam-full-${pkg_version}.tar.gz"
pkg_shasum="0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
  ./configure --prefix "${pkg_prefix}"
  # This is a copy/paste from https://opam.ocaml.org/doc/Install.html#From-Sources
  # to fix builds with ocaml >= 4.06.0
  OCAMLPARAM="safe-string=0,_" make lib-ext
  make
}

do_strip() {
  return 0
}
