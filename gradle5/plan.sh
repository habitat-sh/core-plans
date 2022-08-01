source "$(dirname "${BASH_SOURCE[0]}")/../gradle/plan.sh"

pkg_name=gradle5
pkg_distname=gradle
pkg_origin=core
pkg_version=6.0.1
pkg_source="https://services.gradle.org/distributions/${pkg_distname}-${pkg_version}-bin.zip"
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_shasum=9c2d6f0c6dabf35c2ca7f9f892594e8196816ad08c2168aba56ef2a019165016
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
