pkg_name=lastpass-cli
pkg_origin=core
pkg_version=1.3.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0-or-later")
pkg_description="LastPass CLI is a utility to progromatically interact with LastPass"
pkg_upstream_url="https://github.com/lastpass/lastpass-cli"
pkg_source="https://github.com/lastpass/lastpass-cli/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="b94f591627e06c9fed3bc38007b1adc6ea77127e17c7175c85d497096768671b"
pkg_deps=(
  core/openssl
  core/curl
  core/libxml2
)

pkg_build_deps=(
  core/make
  core/cmake
  core/gcc
  core/pkg-config
  core/patch
)

pkg_bin_dirs=(bin)

do_unpack() {
  UNPACK_TO=${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}
  mkdir "${UNPACK_TO}"
  tar xzf "${HAB_CACHE_SRC_PATH}"/"${pkg_name}-${pkg_version}".tar.gz --directory "${UNPACK_TO}"
}

do_prepare() {
  # Allow curl options to be passed in from command line
  patch -p0 < "${PLAN_CONTEXT}"/patches/Makefile_add_curl_opts.patch
}

do_build() {
  # Define curl as CMAKE doesn't find it properly
  CURL=$(pkg_path_for core/curl)
  CURL_OPTS="-DCURL_LIBRARY:FILEPATH=${CURL}/lib/libcurl.so  -DCURL_INCLUDE_DIR:PATH=${CURL}/include"

  # Call make passing in curl options
  make CURL_OPTS="${CURL_OPTS}"
}

do_check() {
  make test
}
