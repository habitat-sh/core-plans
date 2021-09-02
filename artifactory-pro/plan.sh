pkg_origin=core
pkg_name=artifactory-pro
pkg_version=7.19.4
pkg_description="Artifactory is an advanced binary repository manager for use by build tools (like Maven and Gradle), dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).
Repository managers serve two purposes: they act as highly configurable proxies between your organization and external repositories and they also provide build servers with a deployment destination for your internally generated artifacts."
pkg_upstream_url=https://www.jfrog.com/artifactory/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("JFrog Artifactory EULA")
pkg_source="https://jfrog.bintray.com/${pkg_name}/org/artifactory/pro/jfrog-${pkg_name}/${pkg_version}/jfrog-${pkg_name}-${pkg_version}-linux.tar.gz"
pkg_shasum=2bade99bb12f81f9d043a0ef6ba66649c1d0d6000c2e78bfa7da1262f735142d
pkg_deps=(
  core/glibc
  core/bash
  core/gcc-libs
  core/openjdk11
)
pkg_build_deps=(core/patchelf)
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
  mkdir -p "${pkg_prefix}/artifactory"
  cp -R ./* "${pkg_prefix}/artifactory"

  for dir in router replicator event metadata
  do
    find "${pkg_prefix}"/artifactory/app/$dir/bin -type f -executable \
      -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
      -exec patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" {} \;
  done

  find "${pkg_prefix}"/artifactory/app/third-party/node/bin -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -exec patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;
}

do_strip() {
  return 0
}
