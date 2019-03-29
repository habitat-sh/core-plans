source "../node/plan.sh"

pkg_name=node11
pkg_origin=core
pkg_version=11.13.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=4c29d24de0e6d2bdf7fbac6d37938696a124501d3710b7f6ecdadb0ef5925fb2
pkg_dirname="node-v${pkg_version}"
