source '../redis/plan.sh'

pkg_name=redis3
pkg_origin=core
pkg_version="3.2.13"
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url="http://redis.io"
pkg_license=("BSD-3-Clause")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.redis.io/releases/${pkg_dist_name}-${pkg_version}.tar.gz"
pkg_shasum="862979c9853fdb1d275d9eb9077f34621596fec1843e3e7f2e2f09ce09a387ba"
pkg_dirname="${pkg_dist_name}-${pkg_version}"
