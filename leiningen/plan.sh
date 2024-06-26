pkg_origin=core
pkg_name=leiningen
pkg_version="2.9.8"
pkg_description="Automate Clojure projects without setting your hair on fire."
pkg_upstream_url="https://leiningen.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("EPL-1.0")
pkg_filename="${pkg_version}.zip"
pkg_source="https://github.com/technomancy/${pkg_name}/archive/refs/tags/${pkg_filename}"
pkg_shasum=76f63afd58443d1c43e0d440b11bec07cf1c1ff540aea4db6a23bffd390d6d1e
pkg_deps=(
  core/bash
  core/coreutils
  core/corretto8
)
pkg_bin_dirs=(bin)

do_download() {
  do_default_download
  download_file "https://raw.github.com/technomancy/${pkg_name}/${pkg_version}/bin/lein-pkg" "lein"
}

do_verify() {
  do_default_verify
  verify_file "lein" "9952cba539cc6454c3b7385ebce57577087bf2b9001c3ab5c55d668d0aeff6e9"
}

do_unpack() {
  mv "${HAB_CACHE_SRC_PATH}/${pkg_filename}" "${HAB_CACHE_SRC_PATH}/${pkg_filename%.*}.jar"
}

do_build() {
  fix_interpreter "${HAB_CACHE_SRC_PATH}/lein" core/bash bin/bash
}

do_install() {
  mkdir -p "${pkg_prefix}/share/java"
  cd "${HAB_CACHE_SRC_PATH}" || exit
  sed -i "s|^LEIN_JAR=.*|LEIN_JAR=${pkg_prefix}/share/java/${pkg_filename%.*}.jar|" lein
  chmod +x lein
  install -D lein "${pkg_prefix}/bin/lein"
  install -D "${pkg_filename%.*}.jar" "${pkg_prefix}/share/java/${pkg_filename%.*}.jar"
}
