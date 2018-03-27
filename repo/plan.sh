pkg_origin=core
pkg_name=repo
pkg_version='1.12.33'
pkg_description="Repo is a tool that [Google] built on top of Git. Repo helps
  [Google] manage the many Git repositories, does the uploads to [Google's]
  revision control system, and automates parts of the Android development
  workflow."
pkg_upstream_url="https://code.google.com/p/git-repo/"
pkg_license=('Apache 2.0')
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_source="https://gerrit.googlesource.com/git-repo"
pkg_shasum=d560e02daaf1bb800f806964962a95557ede6150d14e02e73ef1794c9aa98e60
pkg_filename="$pkg_name"
pkg_deps=(
  core/cacerts
  core/gnupg
  # ref: https://gerrit.googlesource.com/git-repo/+/v1.12.33/repo#871
  # Python3 is experimental. Please use 2.6 - 2.7 instead.
  core/python2
)
pkg_build_deps=(
  core/git
)
pkg_bin_dirs=(bin)


do_download() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO

  git clone "$pkg_source"
  pushd "git-repo"
  git checkout tags/v"$pkg_version"
  install "$pkg_name" "$HAB_CACHE_SRC_PATH"/"$pkg_name"
  popd
  rm -rf "git-repo"
}

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  mkdir -p "$pkg_prefix"/bin
  install -m 0755 "$HAB_CACHE_SRC_PATH"/"$pkg_name" "$pkg_prefix"/bin/"$pkg_name"

  # fix shebang in `repo`
  PYTHONPATH="$(pkg_path_for core/python2)"
  sed -i'' "s#/usr/bin/env python#$PYTHONPATH/bin/python#" "$pkg_prefix"/bin/"$pkg_name"
}
