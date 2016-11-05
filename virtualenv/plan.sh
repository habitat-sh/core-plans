pkg_name=virtualenv
pkg_origin=core
pkg_version=15.0.3
pkg_description="virtualenv is a tool to create isolated Python environments. This version is for python2. For python3 use the built-in 'pyvenv'"
pkg_upstream_url=https://virtualenv.pypa.io/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source=https://pypi.io/packages/source/v/$pkg_name/$pkg_name-$pkg_version.tar.gz
pkg_shasum=6d9c760d3fc5fa0894b0f99b9de82a4647e1164f0b700a7f99055034bf548b1d
pkg_deps=(
  core/python2
)
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  export PYTHONPATH="$pkg_prefix/lib/python2.7/site-packages/"
  mkdir -p "$PYTHONPATH"
  python setup.py install --prefix="$pkg_prefix"
}
