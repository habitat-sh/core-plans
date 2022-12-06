# shellcheck disable=SC2034
pkg_name=go19
pkg_origin=core
pkg_version=1.19.3
# Rolled back recent change to core/go17 to facillitate a from-scratch
# base-plan refresh.
pkg_bootstrap_pkg="core/go17"
pkg_bootstrap_version=1.7.6
pkg_description="Go is an open source programming language that makes it easy to
  build simple, reliable, and efficient software."
pkg_upstream_url=https://golang.org/
pkg_license=("BSD-3-Clause")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://dl.google.com/go/go${pkg_version}.src.tar.gz"
pkg_shasum=18ac263e39210bcf68d85f4370e97fb1734166995a1f63fb38b4f6e07d90d212
pkg_dirname=go
pkg_deps=(
  core/glibc
  core/iana-etc
  core/cacerts
)
pkg_build_deps=(
  core/coreutils
  core/inetutils
  core/bash
  core/patch
  core/gcc
  "${pkg_bootstrap_pkg}/${pkg_bootstrap_version}"
  core/perl
)
pkg_bin_dirs=(bin)

do_prepare() {
  export GOOS=linux
  build_line "Setting GOOS=$GOOS"
  export GOARCH=amd64
  build_line "Setting GOARCH=$GOARCH"
  export CGO_ENABLED=1
  build_line "Setting CGO_ENABLED=$CGO_ENABLED"

  export GOROOT
  GOROOT="$PWD"
  build_line "Setting GOROOT=$GOROOT"
  export GOBIN="$GOROOT/bin"
  build_line "Setting GOBIN=$GOBIN"
  # shellcheck disable=SC2154
  export GOROOT_FINAL="$pkg_prefix"
  build_line "Setting GOROOT_FINAL=$GOROOT_FINAL"

  PATH="$GOBIN:$PATH"
  build_line "Updating PATH=$PATH"

  # Building Go after 1.5 requires a previous version of Go to bootstrap with.
  export GOROOT_BOOTSTRAP
  GOROOT_BOOTSTRAP="$(pkg_path_for $pkg_bootstrap_pkg)"
  build_line "Setting GOROOT_BOOTSTRAP=$GOROOT_BOOTSTRAP"

  # Add `cacerts` to the SSL certificate lookup chain
  # shellcheck disable=SC2002
  cat "${PLAN_CONTEXT}/cacerts.patch" \
    | sed -e "s,@cacerts@,$(pkg_path_for cacerts)/ssl/cert.pem,g" \
    | patch -p1

  # Set the dynamic linker from `glibc`
  dynamic_linker="$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2"
  sed -e "s,/lib64/ld-linux-x86-64.so.2,${dynamic_linker}," \
    -i src/cmd/link/internal/amd64/obj.go

  # Use the services database from `iana-etc`
  for f in src/net/port_unix.go src/net/parse_test.go; do
    sed -e "s,/etc/services,$(pkg_path_for iana-etc)/etc/services," -i $f
  done
}

do_build() {
  pushd src > /dev/null || return 1
    bash make.bash --no-clean
  popd > /dev/null || return 1
}

do_check() {
  # The go test suite requires several hardcoded files to be present that might
  # not be present in the build studio. Here we create symlinks to any missing
  # files and then clean them up after the test has completed.
  local _clean_links=()
  declare -A _links

  _links=(
    ["/bin/pwd"]="$(pkg_path_for coreutils)/bin/pwd"
    ["/bin/env"]="$(pkg_path_for coreutils)/bin/env"
    ["/bin/hostname"]="$(pkg_path_for coreutils)/bin/hostname"
    # cgo tests that make getaddrinfo() syscalls use the hardcoded paths
    ["/etc/services"]="$(pkg_path_for iana-etc)/etc/services"
    ["/etc/protocols"]="$(pkg_path_for iana-etc)/etc/protocols"
  )

  for target in "${!_links[@]}"; do
    if [[ ! -r ${target} ]]; then
      ln -sv "${_links[$target]}" "${target}"
      _clean_links+=("${target}")
    fi
  done

  # NOTE: misc/cgo/testsanitizers/cshared_test.go has a known failing test
  # because it strips LD_LIBRARY_PATH and expects libgcc_s.so.1 to be present in
  # the tests temporary directory.
  pushd src > /dev/null || return 1
    env LD_LIBRARY_PATH="$(pkg_path_for gcc)/lib" bash run.bash --no-rebuild -k
  popd > /dev/null || return 1

  # Clean up any symlinks that were added to support the build's test suite.
  for sym in "${_clean_links[@]}"; do
    rm -fv "${sym}"
  done
}

do_install() {
  cp -av bin src lib doc misc "${pkg_prefix}/"

  mkdir -pv "${pkg_prefix}/bin" "${pkg_prefix}/pkg"
  cp -av pkg/{linux_${GOARCH},tool} "${pkg_prefix}/pkg/"
  if [[ -d "pkg/linux_${GOARCH}_race" ]]; then
    cp -av pkg/linux_${GOARCH}_race "${pkg_prefix}/pkg/"
  fi

  # Install the license
  install -v -Dm644 LICENSE "${pkg_prefix}/share/licenses/LICENSE"

  # Remove unneeded Windows files
  rm -fv "${pkg_prefix}/src/*.bat"

  # Move header files to the correct place
  cp -arv "${pkg_prefix}/src/runtime" "${pkg_prefix}/pkg/include"
}

do_strip() {
  # Strip manually since `strip` will not process Go's static libraries.
  for f in "${pkg_prefix}/bin/"* "${pkg_prefix}/pkg/tool/linux_${GOARCH}/"*; do
    strip -s "${f}"
  done
}
