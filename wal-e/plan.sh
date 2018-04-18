pkg_name=wal-e
pkg_version=1.1.0
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('wal-e license')
pkg_description="Continuous Archiving for Postgres"
pkg_upstream_url="https://github.com/wal-e/wal-e"
pkg_source=https://github.com/wal-e/wal-e/archive/v${pkg_version}.tar.gz
pkg_shasum=d3478e6eb4bfe00ac696af3e7ded4a91a0a2db6f9aa1a51ce780e43e4c12d6c7
pkg_deps=(core/envdir core/lzop core/pv core/python)
pkg_bin_dirs=(bin)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
  pyvenv "$pkg_prefix"
  source "$pkg_prefix/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "wal-e[aws]==$pkg_version"
  # Write out versions of all pip packages to package
  pip freeze > "$pkg_prefix/requirements.txt"
}
