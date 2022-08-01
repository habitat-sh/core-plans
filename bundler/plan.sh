pkg_name=bundler
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=2.2.33
pkg_origin=core
pkg_license=('bundler')
pkg_description="The Ruby language dependency manager"
pkg_upstream_url=https://bundler.io/
pkg_deps=(core/ruby core/busybox-static)
pkg_build_deps=()
pkg_bin_dirs=(bin)

do_prepare() {
  export GEM_HOME="$pkg_prefix"
  build_line "Setting GEM_HOME='$GEM_HOME'"
  export GEM_PATH="$GEM_HOME"
  build_line "Setting GEM_PATH='$GEM_PATH'"
}

do_build() {
  return 0
}

do_install() {
  build_line "Installing from RubyGems"
  gem install "$pkg_name" -v "$pkg_version" --no-document
  # Note: We are not cleaning the gem cache as this artifact
  # is reused by other packages for speed.
  wrap_ruby_bin "$pkg_prefix/bin/bundle"
  wrap_ruby_bin "$pkg_prefix/bin/bundler"
}

wrap_ruby_bin() {
  local bin="$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
if test -n "\$DEBUG"; then set -x; fi

export GEM_HOME="$GEM_HOME"
export GEM_PATH="$GEM_PATH"
unset RUBYOPT GEMRC

exec $(pkg_path_for ruby)/bin/ruby ${bin}.real \$@
EOF
  chmod -v 755 "$bin"
}
