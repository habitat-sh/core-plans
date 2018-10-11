source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.12.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=c6552b95062f5e9f3a27da6fdb57914ab4b27a9aa2e783fb050791166554d059
pkg_dirname="node-v${pkg_version}"
