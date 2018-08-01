source '../redis/plan.sh'

pkg_name=redis3
pkg_origin=core
pkg_version="3.2.4"
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url="http://redis.io"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.redis.io/releases/${pkg_dist_name}-${pkg_version}.tar.gz"
pkg_shasum="2ad042c5a6c508223adeb9c91c6b1ae091394b4026f73997281e28914c9369f1"
pkg_dirname="${pkg_dist_name}-${pkg_version}"
