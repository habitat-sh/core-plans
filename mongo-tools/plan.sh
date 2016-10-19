pkg_name=mongo-tools
pkg_origin=core
pkg_version=3.2.10
pkg_description="MongoDB Tools"
pkg_upstream_url=https://github.com/mongodb/mongo-tools
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/mongodb/mongo-tools/archive/r${pkg_version}.tar.gz
pkg_shasum=98a5ff97c2744a3a20e5c88b88cfa02d5b98cf6f7701d6ce9214c178f90af4c4
pkg_dirname=${pkg_name}-r${pkg_version}
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)

do_build() {
  ./set_gopath.sh
  export GOPATH=/hab/cache/src/mongo-tools-r${pkg_version}/.gopath:/hab/cache/src/mongo-tools-r${pkg_version}/vendor
  for i in mongodump mongoexport mongofiles mongoimport mongooplog mongorestore mongostat mongotop; do
    go build -o bin/$i $i/main/$i.go
  done
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp bin/* "${pkg_prefix}/bin"
}
