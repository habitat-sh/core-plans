source "../node/plan.sh"

pkg_name=node12
pkg_origin=core
pkg_version=12.13.1
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=4ee710087687c8de142329d95085f5cba66e454a2c9ea7ec11e1f4b476d6d1ac
pkg_dirname="node-v${pkg_version}"
