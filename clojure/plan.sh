pkg_origin=core
pkg_name=clojure
pkg_version=1.10.1.763
pkg_description="The Clojure programming language"
pkg_upstream_url=https://clojure.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("EPL-1.0")
pkg_source=https://download.${pkg_name}.org/install/${pkg_name}-tools-${pkg_version}.tar.gz
pkg_shasum=2a3ec8a6c3639035c2bba10945ae9007ab0dc9136766b95d2161f354e62a4d10
pkg_deps=(
  core/bash
  core/coreutils
  core/corretto
  core/rlwrap
)
pkg_build_deps=(core/ruby)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/env)
pkg_exports=(
  [nrepl-port]=nrepl-port
)
pkg_svc_user="root"

do_build() {
  fix_interpreter "${HAB_CACHE_SRC_PATH}/${pkg_name}-tools/clj" core/coreutils bin/env
  fix_interpreter "${HAB_CACHE_SRC_PATH}/${pkg_name}-tools/clojure" core/coreutils bin/env
}

do_install() {
  cd "${HAB_CACHE_SRC_PATH}/${pkg_name}-tools" || exit
  sh ./install.sh "${pkg_prefix}"
}
