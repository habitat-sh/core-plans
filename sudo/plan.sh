pkg_name=sudo
pkg_origin=core
pkg_version=1.8.18p1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Execute a command as another user"
pkg_upstream_url="https://www.sudo.ws/"
pkg_license=('ISC')
pkg_source=ftp://ftp.sudo.ws/pub/sudo/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=e5a0471c721281a693025bbde33ebd9d3db43245d83ab8516bbfc23980379434
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/make
)
pkg_deps=(
  core/coreutils
  core/glibc
  core/vim
)
pkg_bin_dirs=(bin sbin)
pkg_include_dirs=(include)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi

  # Export variables to the direct path of executables
  MVPROG="$(pkg_path_for coreutils)/bin/mv"
  export MVPROG
  VIPROG="$(pkg_path_for vim)/bin/vi"
  export VIPROG
}

do_build() {
  ./configure --prefix="$pkg_prefix" --with-editor="$VIPROG" --with-env-editor
  make
}

do_check() {
  # Due to how file permissions are preserved during packaging, we must
  # set a particular file to be owned by root for the `testsudoers/test3`
  # regression test, which compares sudo permissions against a file with
  # root ownership.
  chown root:root plugins/sudoers/regress/testsudoers/test3.d/root

  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
