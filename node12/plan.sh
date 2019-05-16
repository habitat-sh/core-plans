source "../node/plan.sh"

pkg_name=node12
pkg_origin=core
pkg_version=12.0.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=ef7a25d25370a0c618d50ea72f2e78b8777e015160694d7b7cac05188cc0db65
pkg_dirname="node-v${pkg_version}"
