pkg_name=github_changelog_generator
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.13.1
pkg_origin=core
pkg_license=('MIT')
pkg_source=nosuchfile.tar.gz
pkg_description="Changelog generation has never been so easy. Fully automate changelog generation -\
  this gem generate change log file based on tags, issues and merged pull requests from Github \
  issue tracker."
pkg_upstream_url="https://github.com/skywinder/github-changelog-generator/blob/master/github_changelog_generator.gemspec"
pkg_deps=(core/glibc core/ruby core/git core/cacerts)
pkg_build_deps=(core/ruby)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_install() {
  export GEM_HOME=$pkg_prefix
  export GEM_PATH=$pkg_prefix
  gem install $pkg_name -v ${pkg_version} --no-ri --no-rdoc
  write_shim git-generate-changelog
  write_shim github_changelog_generator
}

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
  return 0
}

do_build() {
  return 0
}

write_shim() {
  local bin="$pkg_prefix/bin/$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
export PATH="$(pkg_path_for core/git)/bin"
export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/cert.pem"
export GEM_HOME="$pkg_prefix"
export GEM_PATH="$pkg_prefix"
exec ${bin}.real \$@
EOF
  chmod -v 755 "$bin"
}
