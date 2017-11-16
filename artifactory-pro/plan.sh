pkg_origin=core
pkg_name=artifactory-pro
pkg_version=5.5.2
pkg_description="Artifactory is an advanced binary repository manager for use by build tools (like Maven and Gradle), dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).
Repository managers serve two purposes: they act as highly configurable proxies between your organization and external repositories and they also provide build servers with a deployment destination for your internally generated artifacts."
pkg_upstream_url=https://www.jfrog.com/artifactory/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("JFrog Artifactory EULA")
pkg_source=https://dl.bintray.com/jfrog/${pkg_name}/org/artifactory/pro/jfrog-${pkg_name}/${pkg_version}/jfrog-${pkg_name}-${pkg_version}.zip
pkg_shasum=333ea04274a06de8d0937b2a04390e35eda5498c5ecbe7ac8ba2ff2af5fe1cfd
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
