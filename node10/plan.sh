source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.16.1
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=98c92edcfced73b572917d01a53aa9deefec85d8a2fe96c46fe10ee1d0a7763d
pkg_dirname="node-v${pkg_version}"
