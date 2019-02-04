source "../node/plan.sh"

pkg_name=node11
pkg_origin=core
pkg_version=11.6.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=39ef4f1866f75786baff5959439483fafdc99d3ee3a0568a13cc635d64cf5e0b
pkg_dirname="node-v${pkg_version}"
