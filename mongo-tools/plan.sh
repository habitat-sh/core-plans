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

do_download() {
  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname/src/github.com/mongodb/mongo-tools"
  rm -rf "$REPO_PATH"
  git clone "$pkg_source" "$REPO_PATH"
  pushd "$REPO_PATH" || return 1
  git checkout "tags/r${pkg_version}"
  git submodule update --init --recursive
  popd || return 1
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
  cd "$REPO_PATH"
  mkdir "$REPO_PATH"/bin
  . ./set_goenv.sh
  export GOPATH=/hab/cache/src/mongo-tools-r${pkg_version}/:/hab/cache/src/mongo-tools-r${pkg_version}/vendor
  for i in mongodump mongoexport mongofiles mongoimport mongorestore mongostat mongotop; do
    go build -o bin/$i $i/main/$i.go
  done

}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cd "$REPO_PATH"
  cp /bin/* "${pkg_prefix}/bin"
}
