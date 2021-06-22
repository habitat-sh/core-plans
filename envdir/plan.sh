pkg_name=envdir
pkg_version=1.0.1
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="Envdir runs another program with a modified environment according to files in a specified directory."
pkg_upstream_url="https://github.com/jezdez/envdir"
pkg_source=https://github.com/jezdez/envdir/archive/${pkg_version}.tar.gz
pkg_deps=(core/python)
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
  python -m venv "$pkg_prefix"
  source "$pkg_prefix/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "$pkg_name==$pkg_version"
  # Write out versions of all pip packages to package
  pip freeze > "$pkg_prefix/requirements.txt"
}
