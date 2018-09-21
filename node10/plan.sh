source "../node/plan.sh"

pkg_name=node10
pkg_origin=core
pkg_version=10.11.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=f721552552fb11ef99aba290fc6e696a8647adc98d643db6651e81ed07c4037e
pkg_dirname="node-v${pkg_version}"
