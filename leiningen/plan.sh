pkg_origin=core
pkg_name=leiningen
pkg_version="2.8.1"
pkg_description="Automate Clojure projects without setting your hair on fire."
pkg_upstream_url="https://leiningen.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("EPL-1.0")
pkg_filename="${pkg_name}-${pkg_version}-standalone.zip"
pkg_source="https://github.com/technomancy/${pkg_name}/releases/download/${pkg_version}/${pkg_filename}"
pkg_shasum="fc49bbc7ff25ef42ad9c0a8b5f3d0641702abc9a9a8e847bc845bca4c09a7c58"
pkg_deps=(
  core/bash
  core/coreutils
  core/jdk8/8u151/20171213095056
)
pkg_bin_dirs=(bin)

do_download() {
  do_default_download
  download_file "https://raw.github.com/technomancy/${pkg_name}/${pkg_version}/bin/lein-pkg" "lein"
}

do_verify() {
  do_default_verify
  verify_file "lein" "9108095b5f377bdfb630a5c65bd963ea288b11ab08e868473cbd7763eaa96472"
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
  sed -i'' "s|^LEIN_JAR=.*|LEIN_JAR=${pkg_prefix}/share/java/${pkg_filename%.*}.jar|" lein
  chmod +x lein
  install -D lein "${pkg_prefix}/bin/lein"
  install -D "${pkg_filename%.*}.jar" "${pkg_prefix}/share/java/${pkg_filename%.*}.jar"
}
