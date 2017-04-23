source "../node/plan.sh"

pkg_name=node7
pkg_version=7.6.0
pkg_shasum=809E80265E332FE1A8268E5A73EB219C356810FE86C69FD2D931C52E07211970
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname=node-v$pkg_version
