source "../node/plan.sh"

pkg_name=node12
pkg_origin=core
pkg_version=12.14.1
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=42a7f0777fea8825611cb9250ff927824dba4f7aea854b47d522798acf4bdbc6
pkg_dirname="node-v${pkg_version}"
