pkg_origin=core
pkg_name=clojure
pkg_version=1.10.3
pkg_description="The Clojure programming language"
pkg_upstream_url=https://clojure.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("EPL-1.0")
pkg_source=https://github.com/clojure/clojure/archive/refs/tags/clojure-${pkg_version}.tar.gz
pkg_shasum=949f58fa5d7a189ddc9b41c8a307d8a7f0aef3acad8430551bcd17c3d802bff5
pkg_deps=(
  core/bash
  core/coreutils
  core/corretto
  core/rlwrap
)
pkg_build_deps=(
	core/maven
)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/env)
pkg_exports=(
  [nrepl-port]=nrepl-port
)
pkg_svc_user="root"

pkg_dirname=clojure-clojure-${pkg_version}
do_build() {
	mvn package -Dmaven.test.skip=true
}

do_install() {
	mvn install
}
