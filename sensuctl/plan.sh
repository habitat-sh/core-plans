pkg_name=sensuctl
pkg_filename=sensuctl
pkg_origin=core
pkg_version="2.0.0-beta.2-4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://storage.googleapis.com/sensu-binaries/$pkg_version/linux/amd64/$pkg_filename"
pkg_shasum="4f96e66963bc4d1b4d634ba272469fd14476ecd08afb38a843b8fa0850e89bed"
pkg_deps=()
pkg_bin_dirs=(bin)
pkg_description="Sensu 2.0 Management Command Line Tool"
pkg_upstream_url="https://sensu.io"

do_unpack(){
  return 0
}

do_build(){
  return 0
}

do_install() {
  build_line "Installing $pkg_filename binary"
  chmod +x "$HAB_CACHE_SRC_PATH/$pkg_filename"
  install -D "$HAB_CACHE_SRC_PATH/$pkg_filename" "$pkg_prefix/bin/$pkg_filename"
}
