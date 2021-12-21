pkg_name=curator4
pkg_origin=core
pkg_version=4.3.1
pkg_description="Elasticsearch Curator helps you curate, or manage your indices."
pkg_upstream_url=https://github.com/elastic/curator
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source=nosuchfile.tgz
pkg_deps=(
  core/python2
)
pkg_build_deps=(
  core/virtualenv
)
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
  localedef -i en_US -f UTF-8 en_US.UTF-8
  export LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
  virtualenv "$pkg_prefix"
  # shellcheck source=/dev/null
  source "$pkg_prefix/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "elasticsearch-curator==$pkg_version"
  # Write out versions of all pip packages to package
  pip freeze > "$pkg_prefix/requirements.txt"
}
