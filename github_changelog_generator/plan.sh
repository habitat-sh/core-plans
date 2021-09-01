pkg_name=github_changelog_generator
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.16.1
pkg_origin=core
pkg_license=('MIT')
pkg_description="Changelog generation has never been so easy. Fully automate changelog generation -\
  this gem generate change log file based on tags, issues and merged pull requests from Github \
  issue tracker."
pkg_upstream_url="https://github.com/github-changelog-generator/github-changelog-generator/blob/master/github_changelog_generator.gemspec"
pkg_deps=(core/ruby core/git core/cacerts core/busybox-static core/gcc)
pkg_build_deps=()
pkg_bin_dirs=(bin)

do_prepare() {
  export GEM_HOME="$pkg_prefix"
  build_line "Setting GEM_HOME='$GEM_HOME'"
  export GEM_PATH="$pkg_prefix"
  build_line "Setting GEM_PATH='$GEM_PATH'"
}

do_build() {
  return 0
}

do_install() {
  build_line "Installing from RubyGems"
  gem install "$pkg_name" -v "$pkg_version" --no-document
  build_line "Cleaning cached gems in $pkg_prefix/cache"
  rm -rf "$pkg_prefix/cache"
  write_shim git-generate-changelog
  write_shim github_changelog_generator
}

write_shim() {
  local bin="$pkg_prefix/bin/$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/cert.pem"
export GEM_HOME="$GEM_HOME"
export GEM_PATH="$GEM_PATH"

exec ${bin}.real \$@
EOF
  chmod -v 755 "$bin"
}
