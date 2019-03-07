source "../node/plan.sh"

pkg_name=node11
pkg_origin=core
pkg_version=11.11.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=8cbf2c62359901a5587fcc6699200495490751ce6fb31255c788ac6eb90a1107
pkg_dirname="node-v${pkg_version}"
