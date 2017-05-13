pkg_name=grub
pkg_origin=core
pkg_version=2.02-beta3
pkg_source=git://git.savannah.gnu.org/${pkg_name}.git
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GNU GRUB is a Multiboot boot loader."
pkg_upstream_url=https://www.gnu.org/software/grub/
pkg_license=('GPL-3.0')
pkg_bin_dirs=(bin sbin)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/binutils
  core/bison
  core/cacerts
  core/diffutils
  core/flex
  core/gcc
  core/gettext
  core/git
  core/m4
  core/make
  core/python
)
pkg_deps=(core/glibc)

do_download() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO

  pushd "${HAB_CACHE_SRC_PATH}"

  if [[ ! -d ${pkg_name} ]]; then
    git clone --branch ${pkg_version} ${pkg_source} ${pkg_name}
  else
    pushd ${pkg_name}
    git checkout -f ${pkg_version}
    popd
  fi

  sed -i "s/#! \/usr\/bin\/env bash/#!\/bin\/bash/" ${pkg_name}/autogen.sh

  pkg_filename=${pkg_name}-${pkg_version}.tar.bz2

  tar -cjf "${HAB_CACHE_SRC_PATH}/${pkg_filename}" \
      --transform "s,^\./grub,grub-${pkg_version}," "./${pkg_name}" \
      --exclude-vcs
  popd
}

do_verify() {
  return 0
}

do_build() {
  ./autogen.sh
  do_default_build
}
