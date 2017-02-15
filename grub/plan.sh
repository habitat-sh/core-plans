pkg_name=grub
pkg_origin=core
pkg_version=2.02-beta3
pkg_source=http://git.savannah.gnu.org/cgit/${pkg_name}.git
pkg_shasum=TODO
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description=""
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/make
  core/gcc
  core/diffutils
  core/bison
  core/flex
  core/binutils
  core/gettext
  core/m4
  core/cacerts
  core/git
  core/python
  core/autoconf
  core/automake
)
pkg_deps=(core/glibc)

do_download() {
  export GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  pushd $HAB_CACHE_SRC_PATH
  if [[ ! -d ${pkg_name} ]]; then
    git clone $pkg_source ${pkg_name}
  fi
  pushd ${pkg_name}
  git checkout $pkg_version

  sed -i "s/#! \/usr\/bin\/env bash/#!\/bin\/bash/" autogen.sh
  popd
  pkg_filename=${pkg_name}-${pkg_version}.tar.bz2

  tar -cjf $HAB_CACHE_SRC_PATH/${pkg_filename} \
      --transform "s,^\./grub,grub-${pkg_version}," ./${pkg_name} \
      --exclude-vcs
  pkg_shasum=$(trim $(sha256sum $HAB_CACHE_SRC_PATH/${pkg_filename} | cut -d " " -f 1))
  popd
}

do_build() {
  ./autogen.sh
  ./configure --prefix=${pkg_prefix}
  make
}

