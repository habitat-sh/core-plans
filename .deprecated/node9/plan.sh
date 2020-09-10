source "../node/plan.sh"

pkg_name=node9
pkg_origin=core
pkg_version=9.0.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_license=('MIT')
pkg_upstream_url=https://nodejs.org/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz
pkg_shasum=fe06dafd4f034d2372d34bb064c65ebf5ab4d3d6e04d1745fd108c2a97a9d424

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname=node-v$pkg_version
