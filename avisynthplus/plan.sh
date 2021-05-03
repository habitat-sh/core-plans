pkg_name=avisynthplus
pkg_origin=core
pkg_version="3.7.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license="GNU General Public License GPLv2"
pkg_build_deps=(core/git)
pkg_upstream_url="https://github.com/AviSynth/AviSynthPlus.git"
pkg_include_dirs=(include)

do_begin() {
  do_default_begin
}

do_download() {
    repo_path="${HAB_CACHED_SRC_PATH}/${pkg_dirname}"
    rm -Rf "${repo_path}"
    git clone "${pkg_upstream_url}" "${repo_path}"
	( cd "${HAB_CACHED_SRC_PATH}/${pkg_dirname}" || exit
    git checkout tags/"v$pkg_version"
  )
}

do_clean() {
  do_default_clean
}

do_build() {
 return 0 
}

do_check() {
  return 0
}

do_install() {
  cd "${HAB_CACHED_SRC_PATH}/${pkg_dirname}"
  make install PREFIX="${pkg_prefix}"
}

do_end() {
  do_default_end
}
