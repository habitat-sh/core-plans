source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.10.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=1ed31ba75080b16193f1c7a351807481b1f7da08bfaf7172bc07f0cf07e6ea71
pkg_dirname="node-v${pkg_version}"
