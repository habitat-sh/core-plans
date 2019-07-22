pkg_origin=core
pkg_name=artifactory-pro
pkg_version=6.11.3
pkg_description="Artifactory is an advanced binary repository manager for use by build tools (like Maven and Gradle), dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).
Repository managers serve two purposes: they act as highly configurable proxies between your organization and external repositories and they also provide build servers with a deployment destination for your internally generated artifacts."
pkg_upstream_url=https://www.jfrog.com/artifactory/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("JFrog Artifactory EULA")
pkg_source=https://dl.bintray.com/jfrog/${pkg_name}/org/artifactory/pro/jfrog-${pkg_name}/${pkg_version}/jfrog-${pkg_name}-${pkg_version}.zip
pkg_shasum=61cc41c177cf34780e643759157971a81ce6c72fe73ea2f182b9a79dfbcfc028
pkg_deps=(core/bash core/openjdk11)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

pkg_svc_user=root

do_build() {
  fix_interpreter "bin/artifactory.sh" core/bash bin/bash
}

do_install() {
  build_line "Copying files from $PWD"
  cp -R ./* "$pkg_prefix/"
}
