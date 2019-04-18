pkg_origin=core
pkg_name=cpio
pkg_version='2.12'
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-3.0-or-later')
pkg_source=http://ftp.gnu.org/gnu/cpio/cpio-${pkg_version}.tar.gz
pkg_shasum=08a35e92deb3c85d269a0059a27d4140a9667a6369459299d08c17f713a92e73
pkg_description="GNU cpio copies files into or out of a cpio or tar archive. \
  The archive can be another file on the disk, a magnetic tape, or a pipe"
pkg_upstream_url="https://www.gnu.org/software/cpio/"
pkg_deps=()
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
