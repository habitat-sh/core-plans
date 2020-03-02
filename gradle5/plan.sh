source "$(dirname "${BASH_SOURCE[0]}")/../gradle/plan.sh"

pkg_name=gradle5
pkg_distname=gradle
pkg_origin=core
pkg_version=5.6.4
pkg_source="https://services.gradle.org/distributions/${pkg_distname}-${pkg_version}-bin.zip"
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_shasum=1f3067073041bc44554d0efe5d402a33bc3d3c93cc39ab684f308586d732a80d
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
