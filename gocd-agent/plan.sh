pkg_name=gocd-agent
pkg_origin=core
pkg_version="18.12.0"
pkg_buildnumber="8222"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://download.gocd.org/binaries/${pkg_version}-${pkg_buildnumber}/generic/go-agent-${pkg_version}-${pkg_buildnumber}.zip"
pkg_shasum="f51c6bc6e5ebeb9fe9777017971be9d412437732669597a93160f3f7bf2d0017"
pkg_description="GoCD is an open source tool which is used in software development to help teams and organizations automate the continuous delivery (CD) of software."
pkg_upstream_url="https://www.gocd.org"
pkg_filename="go-agent-${pkg_version}-${pkg_buildnumber}.zip"
pkg_dirname="go-agent-${pkg_version}"
pkg_deps=(
  core/git
  core/jre8
)
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp ./* "${pkg_prefix}/bin"
  mv "${pkg_prefix}/bin/LICENSE" "${pkg_prefix}/"
}
