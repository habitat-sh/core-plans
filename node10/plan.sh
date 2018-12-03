source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.14.1
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=b97b355f3774adbeb4ffce52e275029e767ba9f317f9eb573175410b6255919f
pkg_dirname="node-v${pkg_version}"
