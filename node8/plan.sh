source "../node/plan.sh"

pkg_name=node8
pkg_version=8.3.0
pkg_shasum=33fa7a02f265636c240be9ebd0f93942f77856a9c2c751592da1a0962b6ed010
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname=node-v$pkg_version
