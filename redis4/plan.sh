source '../redis/plan.sh'

pkg_name=redis4
pkg_origin=core
pkg_version="4.0.14"
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url="http://redis.io"
pkg_license=("BSD-3-Clause")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.redis.io/releases/${pkg_dist_name}-${pkg_version}.tar.gz"
pkg_shasum="1e1e18420a86cfb285933123b04a82e1ebda20bfb0a289472745a087587e93a7"
pkg_dirname="${pkg_dist_name}-${pkg_version}"
