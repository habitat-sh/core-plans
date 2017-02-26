pkg_name=composer
pkg_origin=core
pkg_version=1.3.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url=https://getcomposer.org/
pkg_description="Dependency Manager for PHP"
pkg_source=https://getcomposer.org/download/${pkg_version}/${pkg_name}.phar
pkg_filename=${pkg_name}.phar
pkg_shasum=6a4f761aa34bb69fca86bc411a5e9836ca8246f0fcd29f3804b174fee9fb0569
pkg_deps=(core/php core/git)
pkg_bin_dirs=(bin)

do_unpack(){
  return 0
}

do_build() {
  return 0
}

do_check() {
  return 0 # makes no sense here…
}

do_install() {
  install -vDm755 "../$pkg_filename" "$pkg_prefix/bin/$pkg_filename"

  cat<<EOF > "$pkg_prefix/bin/composer"
#!/bin/sh
$(pkg_path_for core/php)/bin/php "$pkg_prefix/bin/$pkg_filename" "\$@"
EOF
  chmod +x "$pkg_prefix/bin/composer"

  # here's our custom do_check()
  set -eo pipefail
  "$pkg_prefix/bin/composer" --version 2>/dev/null | grep -q $pkg_version
}
