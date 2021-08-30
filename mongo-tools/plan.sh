pkg_name=mongo-tools
pkg_origin=core
pkg_version=3.6.23
pkg_description="MongoDB Tools"
pkg_upstream_url=https://github.com/mongodb/mongo-tools
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/mongodb/mongo-tools
pkg_dirname=${pkg_name}-r${pkg_version}
pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/coreutils core/gcc core/make core/git)
pkg_bin_dirs=(bin)

do_setup_environment() {
  build_line "Setting GOPATH=${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  GOPATH="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  export GOPATH
  GO111MODULE=off
  export GO111MODULE
  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname/src/github.com/mongodb/mongo-tools"
  export REPO_PATH
}

do_before() {
  rm -rf "${GOPATH:?}"
}

do_download() {
  git clone "$pkg_source" "$REPO_PATH"
  pushd "$REPO_PATH" || exit 1
    git checkout "tags/r${pkg_version}"
    git submodule update --init --recursive
  popd || exit 1
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_clean() {
  return 0
}

do_build() {
  pushd "$REPO_PATH" || exit 1
    mkdir "${GOPATH}"/bin
    . ./set_goenv.sh
    for i in mongodump mongoexport mongofiles mongoimport mongorestore mongostat mongotop; do
      go build -o "${GOPATH}"/bin/$i $i/main/$i.go
    done
  popd || exit 1
}

do_install() {
  cp "${GOPATH}"/bin/* "${pkg_prefix}"/bin
}
