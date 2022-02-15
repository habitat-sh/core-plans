go_pkg="k8s.io/helm"
pkg_name=helm
pkg_origin=core
pkg_version="3.8.0"
pkg_description="The Kubernetes Package Manager"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://$go_pkg"
pkg_upstream_url="https://helm.sh"
pkg_scaffolding="core/scaffolding-go"
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/coreutils
  core/git
)

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  # also, don't have `go get` bail when not finding a package in that directory
  build_line "go get -d $go_pkg"

  go get -d $go_pkg 2>&1 | grep -q "no Go files"

  pushd "$scaffolding_go_pkg_path" || exit 1
  git fetch --all --tags
  git reset --hard v$pkg_version
  go mod tidy
  popd || exit 1
}

do_build() {
  # For some reason one of the commands in the Makefile launches env with an
  # absolute path so we need to ensure it can find it there.
  env_path="$(command -v env)"
  build_line "ln -fs $env_path /usr/bin/env"
  ln -fs "$env_path" /usr/bin/env

  pushd "$scaffolding_go_pkg_path" || exit 1
  do_default_build
  popd || exit 1
}

do_install() {
  install -m0755 "$scaffolding_go_pkg_path/bin/helm" "$pkg_prefix/bin"
}
