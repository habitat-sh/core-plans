pkg_name=sassc
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=3.3.6
pkg_source=https://github.com/sass/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=3d87edeacdd0f9a21cd0bdcf0e0e40c832b21f469af80eb5e11488c66bf53840
pkg_license=('MIT')
pkg_description='libsass command line driver'
pkg_upstream_url=https://github.com/sass/sassc
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/make core/gcc core/coreutils)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_download() {
  do_default_download
  download_file "https://github.com/sass/libsass/archive/${pkg_version}.tar.gz" \
    "libsass.tar.gz" \
    "4b004b0fcef55420dc916216b1961e0d86925e6bf4a6be37d0b6db42f7f25da5"
}

do_unpack() {
  do_default_unpack
  tar -xzf "${HAB_CACHE_SRC_PATH}/libsass.tar.gz" -C $HAB_CACHE_SRC_PATH
}

do_build() {
  export SASS_LIBSASS_PATH="${HAB_CACHE_SRC_PATH}/libsass-${pkg_version}"
  make
}

do_install() {
  install -D ./bin/sassc "$pkg_prefix/bin/sassc"
}
