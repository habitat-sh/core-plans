pkg_name=azure-cli
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="The Azure command-line interface (CLI) is Microsoft's cross-platform \
  command-line experience for managing Azure resources. Use it in your browser with Azure \
  Cloud Shell, or install it on macOS, Linux, or Windows and run it from the command line."
pkg_upstream_url=https://docs.microsoft.com/en-us/cli/azure
pkg_version=2.0.77
pkg_shasum=9d2867b2a93d506eeba3b1b4d5234ccf9b49c9b5465d8fe4b2f4919c5f3de511
pkg_source="https://github.com/Azure/azure-cli/archive/azure-cli-${pkg_version}.tar.gz"
pkg_dirname="${pkg_name}-${pkg_name}-${pkg_version}"
pkg_build_deps=(
  core/gcc
  core/linux-headers
  core/util-linux
)
pkg_deps=(
  core/coreutils
  core/python
  core/openssl
  core/libffi
  core/bash
  core/glibc
)
pkg_bin_dirs=(bin)

do_prepare() {
  python -m venv "${pkg_prefix}"
  source "${pkg_prefix}/bin/activate"

  pip install --upgrade --force-reinstall pip
  pip install wheel
}

do_build() {
  for d in src/azure-cli src/azure-cli-telemetry src/azure-cli-core src/azure-cli-nspkg src/azure-cli-command_modules-nspkg ; do
    pushd "$d" > /dev/null
    build_line "Building ${d}"
    python setup.py bdist_wheel -d "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/_build"
    popd > /dev/null
  done
}

do_install() {
  all_modules=$(find "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/_build" -name "*.whl")
  # shellcheck disable=SC2086
  pip install --no-cache-dir ${all_modules}
  pip install --no-cache-dir --force-reinstall --upgrade azure-nspkg azure-mgmt-nspkg

  # Write out versions of all pip packages to package
  pip freeze > "${pkg_prefix}/requirements.txt"

  fix_interpreter "${pkg_prefix}/bin/*" core/coreutils bin/env
}

do_strip() {
  return 0
}
