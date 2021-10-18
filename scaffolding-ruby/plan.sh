pkg_name=scaffolding-ruby
pkg_origin=core
pkg_version="0.8.11"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="Habitat Plan Scaffolding for Ruby Applications"
pkg_upstream_url="https://github.com/habitat-sh/core-plans/tree/main/scaffolding-ruby"
pkg_deps=(core/bundler core/ruby core/tar core/busybox-static core/rq core/gcc core/make core/pkg-config)
pkg_build_deps=(core/coreutils core/sed)
pkg_bin_dirs=(bin)

do_prepare() {
  GEM_HOME="$(pkg_path_for bundler)"
  build_line "Setting GEM_HOME=$GEM_HOME"
  GEM_PATH="$GEM_HOME"
  build_line "Setting GEM_PATH=$GEM_PATH"
  export GEM_HOME GEM_PATH
}

do_build() {
  return 0
}

do_install() {
  find lib -type f | while read -r f; do
    install -D -m 0644 "$f" "$pkg_prefix/$f"
  done

  find bin libexec -type f | while read -r f; do
    install -D -m 0755 "$f" "$pkg_prefix/$f"
  done

  # Embed the release version and author information of the program.
  sed \
    -e "s,@author@,$pkg_maintainer,g" \
    -e "s,@version@,$pkg_version/$pkg_release,g" \
    -i "$pkg_prefix/lib/ruby_scaffolding/cli.rb"

  # Wrap the Ruby program so it can be executed from anywhere
  wrap_ruby_bin "$pkg_prefix/bin/gemfile-parser"
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
