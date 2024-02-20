pkg_name=aws-cli
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_version=1.31.4
pkg_description="The AWS Command Line Interface (CLI) is a unified tool to \
  manage your AWS services. With just one tool to download and configure, you \
  can control multiple AWS services from the command line and automate them \
  through scripts."
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

do_prepare() {
  python -m venv "$pkg_prefix"
  # shellcheck source=/dev/null
  source "$pkg_prefix/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "awscli==$pkg_version"
  # Write out versions of all pip packages to package
  pip freeze > "$pkg_prefix/requirements.txt"
}

do_strip() {
  return 0
}
