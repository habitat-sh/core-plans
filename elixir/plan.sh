pkg_origin=core
pkg_name=elixir
pkg_version=1.3.2
pkg_maintainer="Shane Sveller <shane@shanesveller.com>"
pkg_license=('apachev2')
pkg_source=https://github.com/elixir-lang/elixir/archive/v1.3.2.tar.gz
pkg_shasum=be24efee0655206063208c5bb4157638310ff7e063b7ebd9d79e1c77e8344c4b
pkg_deps=(core/busybox core/cacerts core/coreutils core/openssl core/erlang/18.3)
pkg_build_deps=(core/busybox core/cacerts core/coreutils core/make core/openssl core/erlang/18.3)
pkg_bin_dirs=(bin)
# pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
    localedef -i en_US -f UTF-8 en_US.UTF-8
    export LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
}

do_build() {
    fix_interpreter "rebar" core/coreutils bin/env
    make
}
