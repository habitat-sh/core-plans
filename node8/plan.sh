source "../node/plan.sh"

pkg_name=node8
pkg_origin=core
pkg_version=8.14.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=c49f4d2223be9f2d2d73a131e9a25d9668b7ec2c1319d28c3c3658ff503b720c

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname="node-v${pkg_version}"
