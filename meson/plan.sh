pkg_name=meson
pkg_origin=core
pkg_version=0.46.1
pkg_description="The Meson Build System"
pkg_upstream_url="http://mesonbuild.com/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/mesonbuild/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum=2d917692d2cc194e12295f00469fbdf3c045e85d0295e5e59ced69115920ffa0
pkg_deps=(
  core/python
  core/ninja
)
pkg_build_deps=(
  core/patch
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_setup_environment() {
  push_runtime_env PYTHONPATH "$(pkg_path_for core/python)/lib/python3.6/site-packages"
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python3.6/site-packages"
}

do_prepare() {
  mkdir -p "${pkg_prefix}/lib/python3.6/site-packages"
  patch -p0 < "$PLAN_CONTEXT/patches/000_fix_rpath.patch"
}

do_build() {
  python setup.py build
}

do_install() {
  python setup.py install --prefix="$pkg_prefix" --optimize=1 --skip-build
}
