#!/bin/bash
pkg_name=nss-myhostname
pkg_origin=core
pkg_version=0.3
pkg_license=("LGPL-2.1-or-later")
pkg_description="nss-myhostname is a plugin for the GNU Name Service Switch (NSS) \
  functionality of the GNU C Library (glibc) providing host name resolution for \
  the locally configured system hostname as returned by gethostname(2). It is \
  commonly enabled in the default NSS configuration of RHEL and RHEL-like Linux \
  distributions."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="http://0pointer.de/lennart/projects/nss-myhostname/"
pkg_source="http://0pointer.de/lennart/projects/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="2ba744ea8d578d1c57c85884e94a3042ee17843a5294434d3a7f6c4d67e7caf2"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_lib_dirs=(lib)
