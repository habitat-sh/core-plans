source "$(dirname "${BASH_SOURCE[0]}")/../erlang/plan.sh"

pkg_name=erlang20
pkg_origin=core
pkg_version=20.2
pkg_description="A programming language for massively scalable soft real-time systems."
pkg_upstream_url="http://www.erlang.org/"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.erlang.org/download/otp_src_${pkg_version}.tar.gz"
pkg_filename="otp_src_${pkg_version}.tar.gz"
pkg_shasum=24d9895e84b800bf0145d6b3042c2f2087eb31780a4a45565206844b41eb8f23
pkg_dirname="otp_src_${pkg_version}"
