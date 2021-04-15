pkg_name=meson
pkg_origin=core
pkg_version=0.57.1
pkg_description="The Meson Build System"
pkg_upstream_url="http://mesonbuild.com/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/mesonbuild/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=0c043c9b5350e9087cd4f6becf6c0d10b1d618ca3f919e0dcca2cdf342360d5d
pkg_deps=(
  core/python
  core/ninja
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_setup_environment() {
  # core/python can switch minor versions, so we don't want to lock to a specific version
  #   when determining our PYTHONPATH. The following commands allow python itself to tell us
  #   where it expects site packages to live, and allows us to use python to programmatically
  #   tell us where we should put OUR site-packages.

  # We haven't set up our build time PATH at this point, so we need to figure out where python is
  python="$(pkg_path_for core/python)/bin/python"
  python_version="$($python -c 'import sys; print("python{}.{}".format(sys.version_info.major,sys.version_info.minor))')"

  push_runtime_env PYTHONPATH "$($python -c 'import site; print(":".join(site.getsitepackages()))')"
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/${python_version}/site-packages"
  unset python
}

do_prepare() {
  mkdir -p "${pkg_prefix}/lib/${python_version}/site-packages"
}

do_build() {
  python setup.py build
}

do_install() {
  python setup.py install --prefix="$pkg_prefix" --optimize=1 --skip-build
}
