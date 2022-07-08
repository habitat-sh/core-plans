pkg_name=go-path-app
pkg_origin="test"
pkg_description="Go Application to test scaffolding-go"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version="0.1.0"
pkg_license=('Apache-2.0')
pkg_upstream_url="https://github.com/habitat-sh/core-plans"
# @afiune This little hack will let us use the latest installed version of the
# scaffolding-go built with your origin so we can test it before releasing
pkg_scaffolding=$HAB_ORIGIN/scaffolding-go
pkg_bin_dirs=(bin)
