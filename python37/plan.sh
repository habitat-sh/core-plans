# shellcheck disable=SC2148,SC1091
source ../python34/plan.sh

pkg_name=python37
pkg_distname=Python
pkg_version=3.7.6
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Python-2.0')
pkg_description="Python is a programming language that lets you work quickly \
  and integrate systems more effectively."
pkg_upstream_url=https://www.python.org
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_source="https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tgz"
pkg_shasum=aeee681c235ad336af116f08ab6563361a0c81c537072c1b309d6e4050aa2114
pkg_interpreters=(
  bin/python
  bin/python3
  bin/python3.7
)
