pkg_origin=core
pkg_name=artifactory-pro
pkg_version=4.14.3
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
  mkdir -p $pkg_prefix
  cp -R * $pkg_prefix/
}
