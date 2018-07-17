# shellcheck disable=SC2148,SC1091
source ../python/plan.sh

pkg_name=python34
pkg_distname=Python
pkg_version=3.4.8
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Python-2.0')
pkg_description="Python is a programming language that lets you work quickly \
  and integrate systems more effectively."
pkg_upstream_url="https://www.python.org"
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_source="https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tgz"
pkg_shasum="8b1a1ce043e132082d29a5d09f2841f193c77b631282a82f98895a5dbaba1639"

pkg_interpreters=(bin/python bin/python3 bin/python3.4)
