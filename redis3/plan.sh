source '../redis/plan.sh'

pkg_name=redis3
pkg_origin=core
pkg_version="3.2.12"
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url="http://redis.io"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.redis.io/releases/${pkg_dist_name}-${pkg_version}.tar.gz"
pkg_shasum="98c4254ae1be4e452aa7884245471501c9aa657993e0318d88f048093e7f88fd"
pkg_dirname="${pkg_dist_name}-${pkg_version}"
