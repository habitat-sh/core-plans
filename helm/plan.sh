go_pkg="k8s.io/helm"

pkg_name=helm
pkg_origin=core
pkg_version="2.7.2"
pkg_description="Helm is a tool for managing Kubernetes charts"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://$go_pkg"
pkg_upstream_url=$pkg_source
pkg_scaffolding="core/scaffolding-go"
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/which
  core/coreutils
  core/mercurial
)
scaffolding_go_build_deps=()
# note: helm uses github.com/Masterminds/glide but `make bootstrap` we launch as
# part of the build below, takes care of that for use.

do_prepare() {
  build_line "mkdir -p \$GOPATH/bin; export PATH=\$GOPATH/bin:\$PATH"
  mkdir -p "$GOPATH/bin"
  export PATH=$GOPATH/bin:$PATH
}

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  # also, don't have `go get` bail when not finding a package in that directory
  build_line "go get -d $go_pkg"

  go get -d $go_pkg 2>&1 | grep -q "no Go files"

  pushd "$scaffolding_go_pkg_path"
    git reset --hard v$pkg_version
  popd
}

do_build() {
  # For some reason one of the commands in the Makefile launches env with an
  # absolute path so we need to ensure it can find it there.
  build_line "ln -fs \"$(which env)\" /usr/bin/env"
  ln -fs "$(which env)" /usr/bin/env

  pushd "$scaffolding_go_pkg_path"
    build_line "make bootstrap build"
    make bootstrap build
  popd
}

do_install() {
  build_line "copying Helm binary"
  cp -f "${scaffolding_go_pkg_path:?}/bin/helm" "$pkg_prefix/bin"
}
