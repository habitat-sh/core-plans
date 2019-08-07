source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.16.2
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=5936ef12ab3f0ce5fbb6751c1bb41f626b6058f414a297b3d8c5eb418a27e8fe
pkg_dirname="node-v${pkg_version}"
