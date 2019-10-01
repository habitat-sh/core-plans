pkg_name=go
pkg_origin=core
pkg_version=1.13.1
pkg_description="Go is an open source programming language that makes it easy to
  build simple, reliable, and efficient software."
pkg_upstream_url=https://golang.org/
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://storage.googleapis.com/golang/go${pkg_version}.src.tar.gz"
pkg_shasum=81f154e69544b9fa92b1475ff5f11e64270260d46e7e36c34aafc8bc96209358
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
  core/go17
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
  export GOROOT_FINAL="$pkg_prefix"
  build_line "Setting GOROOT_FINAL=$GOROOT_FINAL"

  PATH="$GOBIN:$PATH"
  build_line "Updating PATH=$PATH"

  # Building Go after 1.5 requires a previous version of Go to bootstrap with.
  # This environment variable tells the build system to use our 1.7.x release
  # as the bootstrapping Go.
  export GOROOT_BOOTSTRAP
  GOROOT_BOOTSTRAP="$(pkg_path_for go17)"
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
  pushd src > /dev/null
    bash make.bash --no-clean
  popd > /dev/null
}

do_check() {
  # The test suite requires several hardcoded commands to be present, so we'll
  # add symlinks if they are not already present
  local _clean_cmds=()
  if [[ ! -r /bin/pwd ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/pwd" /bin/pwd
    _clean_cmds+=(/bin/pwd)
  fi
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_cmds+=(/usr/bin/env)
  fi
  if [[ ! -r /bin/hostname ]]; then
    ln -sv "$(pkg_path_for inetutils)/bin/hostname" /bin/hostname
    _clean_cmds+=(/bin/hostname)
  fi

  pushd src > /dev/null
    env LD_LIBRARY_PATH="$(pkg_path_for gcc)/lib" bash run.bash --no-rebuild
  popd > /dev/null

  # Clean up any symlinks that were added to support the build's test suite.
  for cmd in "${_clean_cmds[@]}"; do
    rm -fv "${cmd}"
  done
}

do_install() {
  cp -av bin src lib doc misc "${pkg_prefix}/"

  mkdir -pv "${pkg_prefix}/bin" "${pkg_prefix}/pkg"
  cp -av pkg/{linux_${GOARCH},tool} "${pkg_prefix}/pkg/"
  if [[ -d "pkg/linux_${GOARCH}_race" ]]; then
    cp -av pkg/linux_${GOARCH}_race "${pkg_prefix}/pkg/"
  fi

  # For godoc
  install -v -Dm644 favicon.ico "${pkg_prefix}/favicon.ico"

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
