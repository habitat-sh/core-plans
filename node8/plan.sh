source "../node/plan.sh"

pkg_name=node8
pkg_version=8.1.4
pkg_shasum=5d54960fb3c5e794b784d15e9e85e3853e1189e5ae840f314bf2fc091fbb5c12
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname=node-v$pkg_version
