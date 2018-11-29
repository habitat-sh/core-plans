source "../node/plan.sh"

pkg_name=node11
pkg_origin=core
pkg_version=11.2.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=2766fea693bc7a4750feef16d3c109df44d4319d4763678d60a5e8f177d0fa9e
pkg_dirname="node-v${pkg_version}"
