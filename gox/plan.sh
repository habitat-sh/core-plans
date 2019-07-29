pkg_origin=core
pkg_name=gox
pkg_version=0.4.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A dead simple, no frills Go cross compile tool"
pkg_license=("MPL-2.0")
pkg_upstream_url=https://github.com/mitchellh/gox
pkg_source=https://github.com/mitchellh/gox
pkg_scaffolding=core/scaffolding-go
pkg_bin_dirs=(bin)
scaffolding_go_build_deps=(
  github.com/mitchellh/iochan # AKA Leftpad of the Go world
  github.com/hashicorp/go-version
)
