pkg_origin=core
pkg_name=artifactory-pro
pkg_version=5.10.1
pkg_description="Artifactory is an advanced binary repository manager for use by build tools (like Maven and Gradle), dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).
Repository managers serve two purposes: they act as highly configurable proxies between your organization and external repositories and they also provide build servers with a deployment destination for your internally generated artifacts."
pkg_upstream_url=https://www.jfrog.com/artifactory/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("JFrog Artifactory EULA")
pkg_source=https://dl.bintray.com/jfrog/${pkg_name}/org/artifactory/pro/jfrog-${pkg_name}/${pkg_version}/jfrog-${pkg_name}-${pkg_version}.zip
pkg_shasum=bf9a4cf086a3b720119a39e7c9786250d73609840a9a7d98950fe06d895a56df
pkg_deps=(core/bash core/jre8)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  fix_interpreter "bin/artifactory.sh" core/bash bin/bash
}

do_install() {
  build_line "Copying files from $PWD"
  cp -R ./* "$pkg_prefix/"
}
