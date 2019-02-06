source "$(dirname "${BASH_SOURCE[0]}")/../gradle/plan.sh"

pkg_name=gradle5
pkg_distname=gradle
pkg_origin=core
pkg_version=5.1
pkg_source=https://services.gradle.org/distributions/${pkg_distname}-${pkg_version}-bin.zip
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_shasum=7506638a380092a0406364c79d6c87d03d23017fc25a5770379d1ce23c3fcd4d
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
