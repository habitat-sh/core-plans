pkg_origin=core
pkg_name=homu
pkg_version=0.2.0
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('MIT')
pkg_description="Homu is a gatekeeper for your commits."
pkg_upstream_url=http://homu.io/
pkg_source=nosuchfile.tgz
pkg_deps=(
  core/coreutils/8.24
  core/gcc-libs
  core/git
  core/python
)
pkg_build_deps=(
  core/cacerts
  core/python
)
pkg_bin_dirs=(bin)
pkg_svc_run="bin/homu --verbose"
pkg_expose=(54856)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
  git config --global http.sslCAInfo \
    "$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  pyvenv "$pkg_prefix"
  # shellcheck disable=1090
  source "$pkg_prefix/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "git+https://github.com/servo/$pkg_name.git@b7a9c293d3139a58c778daaf1ba1a472a1a552c6"

  # Write out the dependencies in the package
  pip freeze > "$pkg_prefix/requirements.txt"

  # The SSH helper for git needs to be modified to work correctly
  local git_helper="$pkg_prefix/lib/python3.5/site-packages/homu/git_helper.py"
  fix_interpreter "$git_helper" core/coreutils bin/env
  sed -i "s,^SSH_KEY_FILE.*$,SSH_KEY_FILE='$pkg_svc_path/var/cache/key'," \
    "$git_helper"
}
