pkg_name=ruby25
pkg_origin=core
pkg_version=2.5.7
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/ruby/ruby-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=0b2d0d5e3451b6ab454f81b1bfca007407c0548dea403f1eba2e429da4add6d4
pkg_deps=(core/glibc core/ncurses core/zlib core/openssl core/libyaml core/libffi core/readline)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/sed)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/ruby)
pkg_dirname="ruby-$pkg_version"

do_prepare() {
  export CFLAGS="${CFLAGS} -O3 -g -pipe"
  build_line "Setting CFLAGS='$CFLAGS'"
}

do_build() {
  ./configure \
    --prefix="$pkg_prefix" \
    --enable-shared \
    --disable-install-doc \
    --with-openssl-dir="$(pkg_path_for core/openssl)" \
    --with-libyaml-dir="$(pkg_path_for core/libyaml)"

  make
}

do_check() {
  make test
}

do_install() {
  do_default_install
  gem update --system 2.7.9 --no-document
  gem install rb-readline --no-document
}
