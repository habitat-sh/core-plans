pkg_origin=core
pkg_name=artifactory-pro
pkg_version=4.14.3
pkg_description="Artifactory is an advanced binary repository manager for use by build tools (like Maven and Gradle), dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).
Repository managers serve two purposes: they act as highly configurable proxies between your organization and external repositories and they also provide build servers with a deployment destination for your internally generated artifacts."
pkg_upstream_url=https://www.jfrog.com/artifactory/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("JFrog Artifactory EULA")
pkg_source=https://dl.bintray.com/jfrog/${pkg_name}/org/artifactory/pro/jfrog-${pkg_name}/${pkg_version}/jfrog-${pkg_name}-${pkg_version}.zip
pkg_shasum=470f7cafcc94ffd181b75aac70e033f2414d69ca3cd66fc03cf621c9b8a3368e
pkg_deps=(core/bash core/jre8)
pkg_build_deps=(core/unzip)
pkg_expose=(8081)

do_build() {
  fix_interpreter "bin/artifactory.sh" core/bash bin/bash
  return 0
}

do_install() {
  build_line "Copying files from $PWD"
  mkdir -p "$pkg_prefix"
  cp -R ./* "$pkg_prefix/"
}
