pkg_name=docker-compose
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="Define and run multi-container applications with Docker"
pkg_upstream_url=https://docs.docker.com/compose/install/
pkg_build_deps=(
  core/gawk
  core/sed
)
pkg_deps=(
  core/python
)
pkg_bin_dirs=(bin)

pkg_version() {
  export LC_ALL=en_US LANG=en_US
  pip search --disable-pip-version-check docker-compose | grep '^docker-compose (' | awk -F'[()]' '{print $2}'
}

do_before() {
  update_pkg_version
}

do_prepare() {
  python -m venv "$pkg_prefix"
  # shellcheck source=/dev/null
  source "$pkg_prefix/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "docker-compose==$pkg_version"
  # Write out versions of all pip packages to package
  pip freeze > "$pkg_prefix/requirements.txt"
}

do_strip() {
  return 0
}
