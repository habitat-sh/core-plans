source "../node/plan.sh"

pkg_name=node7
pkg_version=7.6.0
pkg_shasum=809e80265e332fe1a8268e5a73eb219c356810fe86c69fd2d931c52e07211970
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname=node-v$pkg_version
