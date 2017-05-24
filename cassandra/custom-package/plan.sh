pkg_name=my-cassandra
pkg_origin=core
pkg_version=3.10 # this can be customize also
pkg_maintainer="...."
pkg_description="Custom override of cassandra"
pkg_upstream_url="https://cassandra.apache.org/"
pkg_license=("Apache-2.0")
pkg_source=
pkg_deps=(
  core/cassandra # you need the package you override as a dependency
)


do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  # add whatever files you like to the new package
  #
  # install -vDm644 custom_file "$pkg_prefix/custom_file"
  return 0
}
