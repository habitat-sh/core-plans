source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.15.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=dbe467e3dabb6854fcb0cd96e04082268cb1e313ce97a4b7100b2ed152b0a0ab
pkg_dirname="node-v${pkg_version}"
