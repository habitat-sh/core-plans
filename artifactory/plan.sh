pkg_origin=core
pkg_name=artifactory
pkg_version=6.23.13
pkg_description="Artifactory is an advanced binary repository manager for use by build tools (like Maven and Gradle), dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).
Repository managers serve two purposes: they act as highly configurable proxies between your organization and external repositories and they also provide build servers with a deployment destination for your internally generated artifacts."
pkg_upstream_url=https://www.jfrog.com/artifactory/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("JFrog Artifactory EULA")
pkg_source="https://bintray.com/jfrog/${pkg_name}/download_file?file_path=jfrog-artifactory-oss-${pkg_version}.zip"
pkg_shasum=0889c11b768a4b1a6bfb6939280c24e5bd22b36bc3438481b0b420443eb5f379
pkg_deps=(
  core/bash
  core/openjdk11
)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

pkg_svc_user=root

do_build() {
  fix_interpreter "bin/artifactory.sh" core/bash bin/bash
}

do_install() {
  build_line "Copying files from ${PWD}"
  cp -rv "${HAB_CACHE_SRC_PATH}/${pkg_name}-oss-${pkg_version}"/* "${PREFIX}"/
}
