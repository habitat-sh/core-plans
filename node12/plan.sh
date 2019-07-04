source "../node/plan.sh"

pkg_name=node12
pkg_origin=core
pkg_version=12.6.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=8b47a34a5507ee24abb91f26f8799bf3af66172b0ffd45981a7fcf1dde463bd4
pkg_dirname="node-v${pkg_version}"
