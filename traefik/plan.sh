pkg_name=traefik
pkg_description="a modern reverse proxy"
pkg_upstream_url="https://traefik.io"
pkg_origin=core
pkg_version="v1.3.6"
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("MIT")
pkg_source="http://github.com/containous/traefik"
pkg_build_deps=(
  core/node
  core/sed
  core/yarn
)
pkg_deps=()
pkg_bin_dirs=(bin)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_scaffolding=core/scaffolding-go
scaffolding_go_base_path=github.com/containous
scaffolding_go_build_deps=()

pkg_exports=(
  [web_port]=web.port
  [web_host]=web.host
  [web_enabled]=web.enable
)

do_prepare() {
  build_line "adding \$GOPATH/bin to \$PATH"
  export PATH=${scaffolding_go_gopath:?}/bin:$PATH

  build_line "building go-bindata"
  go get github.com/jteeuwen/go-bindata
  go install github.com/jteeuwen/go-bindata/...
}

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  build_line "go get -d github.com/containous/traefik"
  go get -d github.com/containous/traefik

  pushd "${scaffolding_go_gopath:?}/src/github.com/containous/traefik"
    build_line "checking out $pkg_version"
    git reset --hard $pkg_version
  popd
}

do_build() {
  pushd "${scaffolding_go_gopath:?}/src/github.com/containous/traefik"
    build_line "building webui static assets"
    pushd webui
      yarn install

      # We can't use `fix_interpreter` as core/node is not a runtime dep
      for t in node_modules/.bin/*; do
        local interpreter_old
        local interpreter_new
        interpreter_old=".*node"
        interpreter_new="$(pkg_path_for core/node)/bin/node"
        t="$(readlink --canonicalize --no-newline "$t")"
        build_line "Replacing '${interpreter_old}' with '${interpreter_new}' in '${t}'"
        sed -e "s#\#\!${interpreter_old}#\#\!${interpreter_new}#" -i "$t"
      done

      yarn run build
    popd

    build_line "running generate"
    bash script/generate
    build_line "building binary"
    bash script/binary
  popd
}

do_install() {
  build_line "copying traefik binary"
  cp "${scaffolding_go_gopath:?}/src/github.com/containous/traefik/dist/traefik" "${pkg_prefix}/bin"
}
