source "../node/plan.sh"

pkg_name=node7
pkg_version=7.5.0
pkg_shasum=0da8e0288b5c0f136e650b7119219968720caf88b5a67ef0591555113f0844c2
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname=node-v$pkg_version
