source "../node/plan.sh"

pkg_name=node12
pkg_origin=core
pkg_version=12.9.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=88cb425086a87323288c8389e974e8c1001b81fe11c529e64592e8feb2d12f93
pkg_dirname="node-v${pkg_version}"
