source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.16.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=d00f1ffdb0a7413eaaf3afc393fb652ea713db135dcd3ccf6809370a07395713
pkg_dirname="node-v${pkg_version}"
