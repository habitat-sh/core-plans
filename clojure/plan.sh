pkg_origin=core
pkg_name=clojure
pkg_version=1.9.0.273
pkg_description="The Clojure programming language"
pkg_upstream_url=https://clojure.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("EPL-1.0")
pkg_source=https://download.${pkg_name}.org/install/${pkg_name}-tools-${pkg_version}.tar.gz
pkg_shasum=64d1c714d758feee5fc76f3c044c229965d068f140868af0930280bcfbc0b976
pkg_deps=(
  core/bash
  core/coreutils
  core/jdk8
  core/rlwrap
)
pkg_build_deps=(core/ruby)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/env)

do_build() {
  fix_interpreter "${HAB_CACHE_SRC_PATH}/${pkg_name}-tools/clj" core/coreutils bin/env
  fix_interpreter "${HAB_CACHE_SRC_PATH}/${pkg_name}-tools/clojure" core/coreutils bin/env
}

do_install() {
  cd "${HAB_CACHE_SRC_PATH}/${pkg_name}-tools" || exit
  sh ./install.sh "${pkg_prefix}"
}
