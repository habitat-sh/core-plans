go_pkg="github.com/Tecsisa/foulkon"

pkg_name=foulkon
pkg_description="Authorization server written in Go"
pkg_origin=core
pkg_version="v0.4.0"
pkg_source="https://$go_pkg"
pkg_upstream_url=$pkg_source
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/patch
  # core/which # let's just ignore those errors. works fine without.
)
pkg_deps=(
  core/postgresql # for psql in hooks/init
)
pkg_scaffolding=core/scaffolding-go
scaffolding_go_build_deps=()
# note: foulkon uses github.com/Masterminds/glide; but we're using the version
# foulkon uses instead of master (what scaffolding_go_build_deps would give us)

pkg_exports=(
  [port]=service.port
  [host]=service.host
)
pkg_exposes=(port)
pkg_binds_optional=(
  [database]="port superuser_name superuser_password"
)

do_prepare() {
  build_line "mkdir -p \$GOPATH/bin; export PATH=\$GOPATH/bin:\$PATH"
  mkdir -p "$GOPATH/bin"
  export PATH=$GOPATH/bin:$PATH
}

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  # also, don't have `go get` bail when not finding a package in that directory
  build_line "go get -d github.com/Tecsisa/foulkon"

  go get -d github.com/Tecsisa/foulkon 2>&1 | grep -q "no Go files"

  pushd "$scaffolding_go_pkg_path"
    git reset --hard $pkg_version
  popd
}

do_build() {
  pushd "$scaffolding_go_pkg_path"
    build_line "make deps generate"
    # glide.sh is gone - install glide using the github repository and don't call 'make deps'
    wget -O glide.sh https://raw.githubusercontent.com/Masterminds/glide.sh/master/get
    patch <"$PLAN_CONTEXT/glide.patch"
    bash <glide.sh
    glide install
    make generate
    #make deps generate

    # Note: We don't do 'make bin', because it's only these two we need
    #       (It's not worth installing env, and fixing up paths etc...)
    build_line "CGO_ENABLED=0 go install github.com/Tecsisa/foulkon/cmd/{worker,proxy}"
    CGO_ENABLED=0 go install github.com/Tecsisa/foulkon/cmd/worker
    CGO_ENABLED=0 go install github.com/Tecsisa/foulkon/cmd/proxy
  popd
}

do_install() {
  build_line "copying worker and proxy binary"
  cp "${scaffolding_go_gopath:?}/bin/worker" "$pkg_prefix/bin"
  cp "${scaffolding_go_gopath:?}/bin/proxy" "$pkg_prefix/bin"
}
