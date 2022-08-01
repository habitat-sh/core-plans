source "$(dirname "${BASH_SOURCE[0]}")/../gradle/plan.sh"

pkg_name=gradle5
pkg_distname=gradle
pkg_origin=core
pkg_version=6.0.1
pkg_source="https://services.gradle.org/distributions/${pkg_distname}-${pkg_version}-bin.zip"
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_shasum=c7623d1436208a05ec780c0967667f861546c3068a3d7b6c1623dab1c00ee097
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A powerful build system for the JVM"
pkg_upstream_url=http://gradle.org
pkg_license=('Apache-2.0')
