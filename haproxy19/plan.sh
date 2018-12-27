source ../haproxy/plan.sh

pkg_name=haproxy19
pkg_origin=core
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=1.9.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source=https://www.haproxy.org/download/1.8/src/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=16629e66175606de4bd1a2ccd826d607618323d34f400f52bcf048cee003817d
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_upstream_url="https://www.haproxy.org/"
