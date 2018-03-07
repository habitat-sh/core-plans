pkg_name=bats
pkg_origin=core
pkg_version=0.4.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Bats is a TAP-compliant testing framework for Bash. It provides a simple way \
to verify that the UNIX programs you write behave as expected.\
"
pkg_upstream_url="https://github.com/sstephenson/bats"
pkg_license=('MIT')
pkg_source="https://github.com/sstephenson/bats/archive/v$pkg_version.tar.gz"
pkg_shasum="480d8d64f1681eee78d1002527f3f06e1ac01e173b761bc73d0cf33f4dc1d8d7"
pkg_deps=(
  core/bash
  core/coreutils
)
pkg_bin_dirs=(bin)

do_build() {
  fix_interpreter 'install.sh' core/coreutils bin/env
  fix_interpreter 'libexec/*' core/coreutils bin/env
}

do_check() {
  ./bin/bats --tap test
}

do_install() {
  ./install.sh "$pkg_prefix"
}
