pkg_name=composer
pkg_origin=core
pkg_version=2.1.12
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url=https://getcomposer.org/
pkg_description="Dependency Manager for PHP"
pkg_source="https://getcomposer.org/download/${pkg_version}/${pkg_name}.phar"
pkg_filename="${pkg_name}.phar"
pkg_shasum=ae3ec292dd04b4e468aea1e5db4d085f169d8a803aabeb99707f69e9454bf218
pkg_deps=(
  core/php
  core/git
)
pkg_bin_dirs=(bin)

do_unpack(){
  return 0
}

do_build() {
  return 0
}

do_check() {
  "$(pkg_path_for core/php)"/bin/php "../${pkg_filename}" --version 2>&1 | grep -q ${pkg_version}
}

do_install() {
  install -vDm755 "../${pkg_filename}" "${pkg_prefix}/bin/${pkg_filename}"

  cat<<EOF > "${pkg_prefix}/bin/composer"
#!/bin/sh
"$(pkg_path_for core/php)"/bin/php "${pkg_prefix}/bin/${pkg_filename}" "\$@"
EOF
  chmod +x "${pkg_prefix}/bin/composer"
}
