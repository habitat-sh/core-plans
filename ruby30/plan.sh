pkg_name=ruby30
pkg_origin=core
pkg_major=3.0
pkg_version="3.0.6"
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/ruby/${pkg_major}/ruby-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum="6e6cbd490030d7910c0ff20edefab4294dfcd1046f0f8f47f78b597987ac683e"
pkg_deps=(core/glibc core/ncurses core/zlib core/openssl core/libyaml core/libffi core/readline core/nss-myhostname core/gcc-libs)
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
    --disable-install-rdoc \
    --with-openssl-dir="$(pkg_path_for core/openssl)" \
    --with-libyaml-dir="$(pkg_path_for core/libyaml)"

  make
}

do_check() {
  make test
}

do_install() {
  do_default_install
  gem install rb-readline --no-document
}
