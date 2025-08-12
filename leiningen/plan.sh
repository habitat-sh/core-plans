pkg_origin=core
pkg_name=leiningen
pkg_version="2.11.2"
pkg_description="Automate Clojure projects without setting your hair on fire."
pkg_upstream_url="https://leiningen.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("EPL-1.0")
pkg_source="https://github.com/technomancy/leiningen/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum="fe9ee17786be6c3cf4615688a2a82c173369657d84c1b2ffc00b7cd5fd7df1bc"
pkg_deps=(
  core/bash
  core/coreutils
  core/corretto8
  core/clojure
)
pkg_bin_dirs=(bin)

do_build() {
	return 0
}

do_install() {
	install -D ${CACHE_PATH}/bin/lein "${pkg_prefix}/bin/lein"
	sed -e "s#\#\!/usr/bin/env bash#\#\!$(pkg_path_for bash)/bin/bash#" -i "${pkg_prefix}/bin/lein"

	mkdir -p "${pkg_prefix}/share/java"
	download_file https://github.com/technomancy/leiningen/releases/download/${pkg_version}/leiningen-${pkg_version}-standalone.jar leiningen-$pkg_version-standalone.jar
	mv ${HAB_CACHE_SRC_PATH}/leiningen-$pkg_version-standalone.jar ${pkg_prefix}/share/java
	#set java path
	export PATH=$PATH:$(pkg_path_for corretto8)/bin
}
