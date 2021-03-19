pkg_name=gocd-server
pkg_origin=core
pkg_version="18.12.0"
pkg_buildnumber="8222"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://download.gocd.org/binaries/${pkg_version}-${pkg_buildnumber}/generic/go-server-${pkg_version}-${pkg_buildnumber}.zip"
pkg_shasum="5ca5b1f504ef2e47ede02df8ed0145e9cccff18106f8356bb3e6a793df24a707"
pkg_description="GoCD is an open source tool which is used in software development to help teams and organizations automate the continuous delivery (CD) of software."
pkg_upstream_url="https://www.gocd.org"
pkg_filename="go-server-${pkg_version}-${pkg_buildnumber}.zip"
pkg_dirname="go-server-${pkg_version}"
pkg_deps=(
  core/git
  core/corretto8
)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port]=port
  [ssl-port]=ssl-port
)
pkg_exposes=(port ssl-port)

do_build() {
  return 0
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp ./* "${pkg_prefix}/bin"
  mv "${pkg_prefix}/bin/LICENSE" "${pkg_prefix}/"
}
