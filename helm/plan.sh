pkg_name=helm
pkg_origin=core
pkg_version="3.7.1"
pkg_description="The Kubernetes Package Manager"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/helm/helm/archive/refs/tags/v${pkg_version}.tar.gz"
pkg_shasum="5243dd0e07840404a7d19ca0917b2202ee3a5ad70a081cfa455ffd705a8d3624"
pkg_upstream_url="https://helm.sh"

pkg_bin_dirs=(bin)

pkg_build_deps=(
  core/coreutils
  core/go
  core/cacerts
  core/gcc
)

do_prepare() {
  # replace /usr/bin/env with hab pkg install path 
  binpath="$(pkg_path_for core/coreutils)/bin/env"
  sed -i 's/\/usr\/bin\/env/${binpath}/g' Makefile

  # update cacerts
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_build() {
  make
}

do_install() {
  install -m0755 "${CACHE_PATH}/bin/helm" "$pkg_prefix/bin"
}
