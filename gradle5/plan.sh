source "$(dirname "${BASH_SOURCE[0]}")/../gradle/plan.sh"

pkg_name=gradle5
pkg_distname=gradle
pkg_origin=core
pkg_version=5.4.1
pkg_source=https://services.gradle.org/distributions/${pkg_distname}-${pkg_version}-bin.zip
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_shasum="7bdbad1e4f54f13c8a78abc00c26d44dd8709d4aedb704d913fb1bb78ac025dc"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
