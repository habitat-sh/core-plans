source "$(dirname "${BASH_SOURCE[0]}")/../erlang/plan.sh"

pkg_name=erlang21
pkg_origin=core
pkg_version=21.3
pkg_description="A programming language for massively scalable soft real-time systems."
pkg_upstream_url="http://www.erlang.org/"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.erlang.org/download/otp_src_${pkg_version}.tar.gz"
pkg_filename="otp_src_${pkg_version}.tar.gz"
pkg_shasum=69a743c4f23b2243e06170b1937558122142e47c8ebe652be143199bfafad6e4
pkg_dirname="otp_src_${pkg_version}"
