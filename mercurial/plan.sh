pkg_name=mercurial
pkg_origin=core
pkg_version=3.9.2
pkg_description="A free, distributed source control management tool."
pkg_upstream_url="https://www.mercurial-scm.org/"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://www.mercurial-scm.org/release/mercurial-${pkg_version}.tar.gz
pkg_shasum=69046a427c05e83097bf0145a1e37975ae0b6ba4430456e2beca3d2fd96583cf
pkg_deps=(core/glibc core/python2 core/cacerts)
pkg_build_deps=(core/gcc core/make core/python2 core/coreutils core/diffutils core/which)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
  make build PREFIX="$pkg_prefix"
}

do_install() {
  make install-bin PREFIX="$pkg_prefix"
  install_cacerts
}

do_check() {
  fix_test_interpreters
  make tests PREFIX="$pkg_prefix"
}

install_cacerts() {
  build_line "Writing hgrc with cacerts config"
  mkdir -p "${pkg_prefix}/etc/mercurial"
  cat <<EOF > "${pkg_prefix}/etc/mercurial/hgrc"
[web]
cacerts = $(pkg_path_for cacerts)/ssl/cert.pem
EOF
}

#
# We can't use fix_interpreter here without including
# core/coreutils as a runtime dependency.
#
# For a possible solution see:
#   https://github.com/habitat-sh/habitat/issues/1041
#
fix_test_interpreters() {
  files_to_fix_env=(contrib/check-commit
                    contrib/check-code.py
                    tests/bundles/rebase.sh
                    tests/check-perf-code.py
                    tests/dumbhttp.py
                    tests/dummysmtpd.py
                    tests/dummyssh
                    tests/f
                    tests/filterpyflakes.py
                    tests/get-with-headers.py
                    tests/hghave
                    tests/killdaemons.py
                    tests/md5sum.py
                    tests/printenv.py
                    tests/readlink.py
                    tests/revlog-formatv0.py
                    tests/run-tests.py
                    tests/seq.py
                    tests/svn-safe-append.py
                    tests/test-bisect.t
                    tests/test-extdiff.t
                    tests/test-extension.t
                    tests/test-filelog.py
                    tests/test-highlight.t
                    tests/test-largefiles-cache.t
                    tests/test-merge-symlinks.t
                    tests/test-newcgi.t
                    tests/test-newercgi.t
                    tests/test-oldcgi.t
                    tests/test-run-tests.t
                    tests/test-status-inprocess.py
                    tests/tinyproxy.py)

  interpreter_old="/usr/bin/env"
  interpreter_new="$(pkg_path_for coreutils)/bin/env"

  for f in "${files_to_fix_env[@]}"; do
    build_line "Fixing interpreter on $f"
    sed -e "s#\#\!${interpreter_old}#\#\!${interpreter_new}#" -i "$f"
  done
}
