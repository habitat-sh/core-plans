pkg_name=alsa-lib
pkg_origin=core
pkg_version=1.1.9
pkg_description="The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system."
pkg_upstream_url=https://alsa-project.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("LGPL-2.1-or-later")
pkg_source="ftp://ftp.alsa-project.org/pub/lib/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=488373aef5396682f3a411a6d064ae0ad196b9c96269d0bb912fbdeec94b994b
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/m4
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_check() {
  make check
}

do_end() {
  if [[ -n "${_clean_file}" ]]; then
    rm -fv /usr/bin/file
  fi
}
