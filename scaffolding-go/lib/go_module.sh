#
# Go Module Mode
#

do_default_before() {
  return 0
}

do_default_download() {
  return 0
}

do_default_clean() {
  build_line "Clean go cache"
  pushd "$SRC_PATH" > /dev/null
    go clean -r -i
  popd > /dev/null
}

do_default_verify() {
  return 0
}

do_default_unpack() {
  return 0
}

do_default_build() {
  pushd "$SRC_PATH" > /dev/null
    if [[ -f "Makefile" ]]; then
      make
    else
      go build
    fi
  popd > /dev/null
}

do_default_install() {
  # Avoids the need to have pkg_bin_dirs=(bin) on every plan
  mkdir -p "${pkg_prefix}/bin/"
  mv "${SRC_PATH}/${pkg_name}" "${pkg_prefix}/bin/"
}
