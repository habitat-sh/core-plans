pkg_name=bazel
pkg_origin=core
pkg_version='0.13.0'
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Apache-2.0')
pkg_description="Build and test software of any size, quickly and reliably"
pkg_upstream_url='https://www.bazel.build/'
pkg_source="https://github.com/bazelbuild/bazel/releases/download/${pkg_version}/${pkg_name}-${pkg_version}-dist.zip"
pkg_shasum='82e9035084660b9c683187618a29aa896f8b05b5f16ae4be42a80b5e5b6a7690'
pkg_build_deps=(
  core/python
  core/protobuf-cpp
  core/gcc
  core/libarchive
  core/which
  core/patch
)
pkg_deps=(
  core/glibc
  core/jdk8
  core/gcc-libs
  core/zip
  core/unzip
  core/coreutils
)
pkg_bin_dirs=(bin)

do_prepare() {
  pushd .. >/dev/null
  patch -p1 -i "${PLAN_CONTEXT}/do_not_clear_env.patch"
  popd >/dev/null
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for core/coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  pushd .. >/dev/null
  export TMPDIR=/tmp
  ./compile.sh
  popd >/dev/null
}

do_install() {
  pushd .. >/dev/null
  mkdir -p "${pkg_prefix}/bin"
  cp ./output/bazel "${pkg_prefix}/bin/"
  popd >/dev/null
}

do_end() {
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}

do_strip() {
  return 0
}
