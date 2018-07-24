source '../redis/plan.sh'

pkg_name=redis4
pkg_origin=core
pkg_version="4.0.10"
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url="http://redis.io"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.redis.io/releases/${pkg_dist_name}-${pkg_version}.tar.gz"
pkg_shasum="1db67435a704f8d18aec9b9637b373c34aa233d65b6e174bdac4c1b161f38ca4"
pkg_dirname="${pkg_dist_name}-${pkg_version}"
