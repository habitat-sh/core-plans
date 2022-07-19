pkg_origin=core
pkg_name=elixir
pkg_version=1.11.4
pkg_description="A dynamic, functional language designed for building scalable and maintainable applications. Elixir leverages the Erlang VM, known for running low-latency, distributed and fault-tolerant systems, while also being successfully used in web development and the embedded software domain."
pkg_upstream_url=http://elixir-lang.org
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/elixir-lang/elixir/archive/v${pkg_version}.tar.gz"
pkg_shasum=85c7118a0db6007507313db5bddf370216d9394ed7911fe80f21e2fbf7f54d29
pkg_deps=(
  core/busybox
  core/cacerts
  core/coreutils
  core/openssl
  core/erlang
)
pkg_build_deps=(
  core/busybox
  core/make
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
  localedef -i en_US -f UTF-8 en_US.UTF-8
  # ensure locale is also set for buildtime; otherwise compilation will throw a warning
  export LC_ALL=en_US.UTF-8 
  export LANG=en_US.UTF-8
}

do_setup_environment() {
  # ensure locale is also set for runtime environment; otherwise
  # stderr will be populated with 'warning: the VM is running with 
  # native name encoding of latin1 which may cause Elixir to malfunction...se 
  # ensure your locale is set to UTF-8 (which can be verified by running "locale" in your shell'
  push_runtime_env LC_ALL "en_US.UTF-8"
  push_runtime_env LANG "en_US.UTF-8"
}

do_build() {
  fix_interpreter "rebar" core/coreutils bin/env
  fix_interpreter "rebar3" core/coreutils bin/env
  fix_interpreter "bin/*" core/coreutils bin/env
  fix_interpreter "lib/elixir/generate_app.escript" core/coreutils bin/env
  make
}
