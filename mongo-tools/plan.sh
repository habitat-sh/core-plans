pkg_name=mongo-tools
pkg_origin=core
pkg_version=3.4.2
pkg_description="MongoDB Tools"
pkg_upstream_url=https://github.com/mongodb/mongo-tools
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/mongodb/mongo-tools/archive/r${pkg_version}.tar.gz
pkg_shasum=fe43e879e6a68e2c351604c529816aa60076598b99cfea8011eb2bff50b10194
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
