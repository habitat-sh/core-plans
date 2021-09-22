pkg_name=dep
pkg_origin=core
pkg_version=0.5.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Go dependency management tool"
pkg_license="BSD-3-Clause"
pkg_source="https://github.com/golang/dep/cmd/dep"
pkg_upstream_url="https://github.com/golang/dep"
pkg_scaffolding="core/scaffolding-go"
pkg_bin_dirs=(bin)

do_download() {
  scaffolding_go_download

  pushd "${scaffolding_go_pkg_path}" >/dev/null
  git reset --hard "v${pkg_version}"
  popd >/dev/null
}

do_build() {
  pushd "${scaffolding_go_pkg_path}/../.." >/dev/null
  DEP_BUILD_ARCHS="amd64" DEP_BUILD_PLATFORMS="linux" bash -x hack/build-all.bash
  popd >/dev/null
}

do_install() {
  cp "${scaffolding_go_pkg_path}/../../release/dep-linux-amd64" "${pkg_prefix}/bin/dep"
}
