source "../node/plan.sh"

pkg_name=node12
pkg_origin=core
pkg_version=12.7.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=d5e63fd4ee88d539a69b9e71631d03014bd8e98596e741515e3d7aa930f4630a
pkg_dirname="node-v${pkg_version}"
