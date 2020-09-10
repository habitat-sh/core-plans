source "../corretto/plan.sh"

pkg_name=corretto11
pkg_origin=core
pkg_version=11.0.2.9.3
pkg_description=('Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon.')
pkg_license=("GPL-2.0-only")
pkg_upstream_url=https://aws.amazon.com/corretto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://d3pxv6yz143wms.cloudfront.net/${pkg_version}/amazon-corretto-${pkg_version}-linux-x64.tar.gz
pkg_shasum=be8452a78baa077e19afbfa64070b26275030267a5ea4e837dec7a30eff85c9c
pkg_dirname="amazon-corretto-${pkg_version}-linux-x64"
