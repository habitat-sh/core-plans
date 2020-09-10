source "$(dirname "${BASH_SOURCE[0]}")/../erlang/plan.sh"

pkg_name=erlang22
pkg_origin=core
pkg_version=22.3
pkg_description="A programming language for massively scalable soft real-time systems."
pkg_upstream_url="http://www.erlang.org/"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.erlang.org/download/otp_src_${pkg_version}.tar.gz"
pkg_filename="otp_src_${pkg_version}.tar.gz"
pkg_shasum=5c35b952808fa933ca95a9d259818aee27cb17ca96067da0fda2f035259ee612
pkg_dirname="otp_src_${pkg_version}"
