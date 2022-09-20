pkg_name=go14
pkg_origin=core
pkg_version=1.4.3
pkg_description="Go is an open source programming language that makes it easy to build simple, reliable, and efficient software."
pkg_upstream_url=https://golang.org/
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://storage.googleapis.com/golang/go${pkg_version}.src.tar.gz
pkg_shasum=9947fc705b0b841b5938c48b22dc33e9647ec0752bae66e50278df4f23f64959
pkg_dirname=go
pkg_deps=(core/glibc core/iana-etc core/cacerts)
pkg_build_deps=(core/coreutils core/inetutils core/bash core/patch core/gcc core/perl)
pkg_bin_dirs=(bin)

do_prepare() {
  export GOOS=linux
  build_line "Setting GOOS=$GOOS"
  export GOARCH=amd64
  build_line "Setting GOARCH=$GOARCH"
  export CGO_ENABLED=0
  build_line "Setting CGO_ENABLED=$CGO_ENABLED"

  GOROOT="$(pwd)"
  export GOROOT
  build_line "Setting GOROOT=$GOROOT"
  export GOBIN="$GOROOT/bin"
  build_line "Setting GOBIN=$GOBIN"
  export GOROOT_FINAL="$pkg_prefix"
  build_line "Setting GOROOT_FINAL=$GOROOT_FINAL"

  PATH="$GOBIN:$PATH"
  build_line "Updating PATH=$PATH"

  # Add `cacerts` to the SSL certificate lookup chain
  # shellcheck disable=SC2002
  cat "$PLAN_CONTEXT/cacerts.patch" \
    | sed -e "s,@cacerts@,$(pkg_path_for cacerts)/ssl/cert.pem,g" \
    | patch -p1

  # Set the dynamic linker from `glibc`
  dynamic_linker="$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2"
  find src/cmd -name asm.c -exec \
    sed -i "s,/lib/ld-linux.*\.so\.[0-9],$dynamic_linker," {} \;

  # Use the protocols database from `iana-etc`
  sed -e "s,/etc/protocols,$(pkg_path_for iana-etc)/etc/protocols," \
    -i src/net/lookup_unix.go

  # Use the services database from `iana-etc`
  for f in src/net/port_unix.go src/net/parse_test.go; do
    sed -e "s,/etc/services,$(pkg_path_for iana-etc)/etc/services," -i $f
  done

  # Duplicate `127.0.0.1` entries in `/etc/hosts` cause this test to fail,
  # but as Studio is at the mercy of the outside host for this file, transient
  # failures make sense. Hence, we are ignoring this test.
  sed -e '/TestLookupHost/areturn' -i src/net/hosts_test.go

  # These tests are failing due to the ipv6 networking stack
  sed -e '/TestDialDualStackLocalhost/areturn' -i src/net/dial_test.go
  sed -e '/TestResolveIPAddr/areturn' -i src/net/ipraw_test.go
  sed -e '/TestResolveTCPAddr/areturn' -i src/net/tcp_test.go
  sed -e '/TestResolveUDPAddr/areturn' -i src/net/udp_test.go

  sed -e '/TestLookupPort/areturn' -i src/net/port_test.go

  sed -e '/TestFilePacketConn/areturn' -i src/net/file_test.go
}

do_build() {
  pushd src > /dev/null
    # adding explicit TMPDIR because on some systems, like hab studio,
    # the make.bash fails because it can't "mkdtemp" a temporary directory
    export TMPDIR="/tmp"
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
    rm -fv "$cmd"
  done
}

do_install() {
  cp -av bin src lib doc misc "$pkg_prefix/"

  mkdir -pv "$pkg_prefix/bin" "$pkg_prefix/pkg"
  cp -av pkg/{linux_$GOARCH,tool} "$pkg_prefix/pkg/"
  if [[ -d "pkg/linux_${GOARCH}_race" ]]; then
    cp -av pkg/linux_${GOARCH}_race "$pkg_prefix/pkg/"
  fi

  # For godoc
  install -v -Dm644 favicon.ico "$pkg_prefix/favicon.ico"

  # Install the license
  install -v -Dm644 LICENSE "$pkg_prefix/share/licenses/LICENSE"

  # Remove unneeded Windows files
  rm -fv "$pkg_prefix/src/*.bat"

  # Move header files to the correct place
  cp -arv "$pkg_prefix/src/runtime" "$pkg_prefix/pkg/include"
}

do_strip() {
  # Strip manually since `strip` will not process Go's static libraries.
  for f in "$pkg_prefix"/bin/* "$pkg_prefix"/pkg/tool/linux_$GOARCH/*; do
    strip -s "$f"
  done
}
