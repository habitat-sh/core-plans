pkg_name=traefik
pkg_description="a modern reverse proxy"
pkg_upstream_url="https://traefik.io"
pkg_origin=core
# note: to have the version match the codename, please update both values when
#       updating this for a new release
pkg_version="1.7.33"
traefik_codename="maroilles"
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("MIT")
pkg_source="http://github.com/traefik/traefik"
pkg_build_deps=(
  core/node6
  core/sed
  core/yarn
)
pkg_deps=()
pkg_bin_dirs=(bin)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_scaffolding=core/scaffolding-go
scaffolding_go_base_path=github.com/traefik
scaffolding_go_build_deps=()

pkg_exports=(
  [web_port]=web.port
  [web_host]=web.host
  [web_enabled]=web.enable
)

do_prepare() {
  export PATH="${scaffolding_go_gopath:?}/bin:${PATH}"
  export VERSION="v${pkg_version}"
  export CODENAME="${traefik_codename}"
  go get github.com/containous/go-bindata
  go install github.com/containous/go-bindata/...
}

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  go get -d github.com/traefik/traefik

  pushd "${scaffolding_go_gopath:?}/src/github.com/traefik/traefik"
    git reset --hard "v${pkg_version}"
  popd
}

do_build() {
  # Note (2018/01/08): yarn uses core/node; traefik's build process depends on
  # node-sass, which needs node6. So, we ensure that this ends up picking up
  # the right node version for traefik to build.
  # An alternative way would have been to change the order of dependencies in
  # pkg_deps, but this is too brittle.
  PATH=$(pkg_path_for core/node6)/bin:${PATH}
  export PATH
  pushd "${scaffolding_go_gopath:?}/src/github.com/traefik/traefik"
    pushd webui
      yarn install

      # We can't use `fix_interpreter` as core/node6 is not a runtime dep
      for t in node_modules/.bin/*; do
        local interpreter_old
        local interpreter_new
        interpreter_old=".*node"
        interpreter_new="$(pkg_path_for core/node6)/bin/node"
        t="$(readlink --canonicalize --no-newline "${t}")"
        sed -e "s#\#\!${interpreter_old}#\#\!${interpreter_new}#" -i "${t}"
      done

      yarn run build
    popd

    bash script/generate
    bash script/binary
  popd
}

do_install() {
  cp "${scaffolding_go_gopath:?}/src/github.com/traefik/traefik/dist/traefik" "${pkg_prefix}/bin"
}
