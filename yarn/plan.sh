pkg_name=yarn
pkg_origin=core
pkg_version=1.16.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Yarn is a package manager for your code. It allows you to use and share code with other developers from around the world. Yarn does this quickly, securely, and reliably so you don’t ever have to worry."
pkg_upstream_url=https://yarnpkg.com/
pkg_license=('BSD-2-Clause')
pkg_source="https://yarnpkg.com/downloads/${pkg_version}/yarn-v${pkg_version}.tar.gz"
pkg_shasum=df202627d9a70cf09ef2fb11cb298cb619db1b958590959d6f6e571b50656029
pkg_bin_dirs=(bin)
pkg_build_deps=()
pkg_deps=(
  core/coreutils
  core/node
  core/sed
)

# Yarn unpacks into dist, so fix that
do_unpack() {
  pushd "${HAB_CACHE_SRC_PATH}" > /dev/null
    mkdir -pv "${pkg_dirname}"
    tar --strip-components=1 --directory="${pkg_dirname}" -xf "${pkg_filename}"
  popd > /dev/null
}

do_build() {
  return 0
}

do_install() {
  find bin -type f | while read -r f; do
    install -D -m 0755 "${f}" "${pkg_prefix}/${f}"
  done
  rm -rf "${pkg_prefix}/bin"/*.cmd

  find lib LICENSE package.json -type f | while read -r f; do
    install -D -m 0644 "${f}" "${pkg_prefix}/${f}"
  done
}
