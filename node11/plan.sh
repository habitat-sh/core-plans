source "../node/plan.sh"

pkg_name=node11
pkg_origin=core
pkg_version=11.0.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=1f7e67f8d713e6a0c3b786d3b3d2eb03b7825cfbed395a5a9565e3c606caea3d
pkg_dirname="node-v${pkg_version}"
