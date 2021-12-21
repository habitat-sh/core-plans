pkg_name=kubectl
pkg_origin=core
pkg_description="kubectl CLI tool"
pkg_upstream_url=https://github.com/kubernetes/kubernetes
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.23.0
pkg_source=https://github.com/kubernetes/kubernetes/archive/v${pkg_version}.tar.gz
pkg_shasum=5b4a27cbf0675a5d5e5228a58795bc76a0ec13df71ad5b423caa240bef2c574d
pkg_dirname="kubernetes-${pkg_version}"

pkg_bin_dirs=(bin)

pkg_build_deps=(
  core/git
  core/make
  core/gcc
  core/go
  core/diffutils
  core/which
  core/rsync
  core/coreutils
)

pkg_deps=(
  core/glibc
)

do_prepare() {
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  make kubectl
  return $?
}

do_install() {
  cp _output/bin/kubectl "${pkg_prefix}/bin/"
  return $?
}

do_end() {
  # Clean up
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
