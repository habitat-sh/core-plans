source ../haproxy/plan.sh

pkg_name=haproxy17
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=1.7.11
pkg_source=https://www.haproxy.org/download/1.7/src/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=d564b8e9429d1e8e13cb648bf4694926b472e36da1079df946bb732927b232ea
pkg_dirname="${pkg_distname}-${pkg_version}"
