source "../node/plan.sh"

pkg_name=node11
pkg_origin=core
pkg_version=11.15.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=2045ace2fcf130b0f18b82b027015dd31b262c2c97fe9bf2533227c52b59c01c
pkg_dirname="node-v${pkg_version}"
