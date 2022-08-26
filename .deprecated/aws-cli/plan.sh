pkg_name=aws-cli
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services."
pkg_upstream_url=https://aws.amazon.com/cli/
pkg_build_deps=(
  core/gawk
  core/sed
)
pkg_deps=(
  core/groff
  core/python
)
pkg_bin_dirs=(bin)

pkg_version() {
  export LC_ALL=en_US LANG=en_US
  pip search --disable-pip-version-check awscli | grep '^awscli (' | awk -F'[()]' '{print $2}'
}

do_before() {
  update_pkg_version
}

do_prepare() {
  python -m venv "${pkg_prefix}"
  # shellcheck source=/dev/null
  source "${pkg_prefix}/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "awscli==${pkg_version}"
  # Write out versions of all pip packages to package
  pip freeze > "${pkg_prefix}/requirements.txt"
}

do_strip() {
  return 0
}
