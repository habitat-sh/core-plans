pkg_name=fail2ban
pkg_origin=core
pkg_version="0.10.4"
pkg_description="Daemon to ban hosts that cause multiple authentication errors."
pkg_source="https://github.com/fail2ban/fail2ban/archive/${pkg_version}.tar.gz"
pkg_shasum="d6ca1bbc7e7944f7acb2ba7c1065953cd9837680bc4d175f30ed155c6a372449"
pkg_upstream_url="https://www.fail2ban.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_build_deps=(
  core/python
  core/coreutils
)
pkg_deps=(
  core/iptables
  core/sqlite
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root

do_prepare() {
  do_default_prepare
  export DO_CHECK=true
}

do_build() {
  interpreter_old="/usr/bin/env"
  interpreter_new="$(pkg_path_for coreutils)/bin/env"

  grep -nrlI '\#\!/usr/bin/env' "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version" | while read -r filesToFix; do
    sed -e "s#\#\!${interpreter_old}#\#\!${interpreter_new}#" -i "$filesToFix"
  done

  ./fail2ban-2to3
  python setup.py install --prefix="$pkg_prefix"
}

do_check() {
  cd "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version"
  ./fail2ban-testcases-all
}

do_install() {
  return 0
}
