pkg_name=kubernetes
pkg_origin=core
pkg_version=1.23.0
pkg_description="Production-Grade Container Scheduling and Management"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/kubernetes/${pkg_name}"
pkg_upstream_url=https://kubernetes.io/

pkg_bin_dirs=(bin)

pkg_build_deps=(
  core/git
  core/make
  core/gcc
  core/go
  core/diffutils
  core/which
  core/rsync
  core/coreutils
)

pkg_deps=(
  core/glibc
  core/coreutils
)

do_before(){
  GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  export GOPATH
  SRC_PATH="${GOPATH}/src/k8s.io/${pkg_name}"
  export SRC_PATH

  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_download() {
  if [ ! -d "${SRC_PATH}" ]; then
    git clone "${pkg_source}" "${SRC_PATH}"
  fi

  pushd "${SRC_PATH}" &>/dev/null || exit 1
    git checkout "v${pkg_version}"
  popd > /dev/null || exit 1
}

do_clean() {
  pushd "${SRC_PATH}" &>/dev/null || exit 1
    make clean
  popd &>/dev/null || exit 1
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  make all
}

do_install() {
  cp _output/bin/* "${pkg_prefix}"/bin
}

do_end() {
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
