pkg_origin=core
pkg_name=artifactory-pro
pkg_version=5.3.1
pkg_description="Artifactory is an advanced binary repository manager for use by build tools (like Maven and Gradle), dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).
Repository managers serve two purposes: they act as highly configurable proxies between your organization and external repositories and they also provide build servers with a deployment destination for your internally generated artifacts."
pkg_upstream_url=https://www.jfrog.com/artifactory/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("JFrog Artifactory EULA")
pkg_source=https://dl.bintray.com/jfrog/${pkg_name}/org/artifactory/pro/jfrog-${pkg_name}/${pkg_version}/jfrog-${pkg_name}-${pkg_version}.zip
pkg_shasum=96f7f3d4eb4dc781f946ce55a6da623782c9f074de416f6f2c43f7cc2a625a6a
pkg_deps=(core/bash core/jre8)
pkg_build_deps=(core/unzip)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

do_build() {
  fix_interpreter "bin/artifactory.sh" core/bash bin/bash
  return 0
}

do_install() {
  build_line "Copying files from $PWD"
  mkdir -p "$pkg_prefix"
  cp -R ./* "$pkg_prefix/"
}
