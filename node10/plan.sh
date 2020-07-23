source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.18.1
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=80a61ffbe6d156458ed54120eb0e9fff7b626502e0986e861d91b365f7e876db
pkg_dirname="node-v${pkg_version}"
