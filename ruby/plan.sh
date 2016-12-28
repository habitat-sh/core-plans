pkg_name=ruby
pkg_origin=core
pkg_version=2.3.1
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=b87c738cb2032bf4920fef8e3864dc5cf8eae9d89d8d523ce0236945c5797dcd
pkg_deps=(core/glibc core/ncurses core/zlib core/openssl core/libyaml core/libffi)
pkg_build_deps=(core/coreutils core/diffutils core/patch core/make core/gcc core/sed)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_interpreters=(bin/ruby)

do_build() {
    CFLAGS="${CFLAGS} -O3 -g -pipe"
    patch -p1 -i "$PLAN_CONTEXT/patches/ruby-2_1_3-no-mkmf.patch"

    # Resolves issue for older versions of RubyGems which require new trust
    # authority SSL certificate required as of 2016-10-06.
    #
    # Most likely the next Ruby release will resolve this issue as the vendored
    # version of RubyGems should be newer.
    #
    # For more details see:
    # http://guides.rubygems.org/ssl-certificate-update/#manual-solution-to-ssl-issue
    cp -v "$PLAN_CONTEXT/GlobalSignRootCA.pem" lib/rubygems/ssl_certs/

    ./configure "--prefix=$pkg_prefix" \
                --enable-shared \
                --disable-install-doc \
                "--with-openssl-dir=$(_resolve_dependency core/openssl)" \
                "--with-libyaml-dir=$(_resolve_dependency core/libyaml)"
    make
}

do_install() {
  do_default_install
  gem update --system --no-document
  gem install rb-readline --no-document
}

do_check() {
  make test
}
