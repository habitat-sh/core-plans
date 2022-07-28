pkg_name=xxhash
pkg_origin=core
pkg_version="0.8.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Extremely fast non-cryptographic hash algorithm"
pkg_license=('BSD 2-Clause License' 'GPL V2')
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc core/git)
pkg_upstream_url="https://github.com/Cyan4973/xxHash"
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

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
  cd "${HAB_CACHED_SRC_PATH}/${pkg_dirname}"
  make
}

do_check() {
  return 0
}

do_install() {
  cd "${HAB_CACHED_SRC_PATH}/${pkg_dirname}"
  make install
}

do_end() {
  do_default_end
}
