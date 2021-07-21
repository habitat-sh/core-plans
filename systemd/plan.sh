pkg_name=systemd
pkg_origin=core
pkg_version=247
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="systemd is an init system used in Linux distributions to \
bootstrap the user space. Subsequently to booting, it is used to manage system \
processes."
pkg_license=('GPL-2.0-only' 'LGPL-2.1-or-later')
pkg_source="https://github.com/systemd/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_upstream_url="https://github.com/systemd/systemd"
pkg_shasum=77146f7b27334aa69ef6692bed92c3c893685150f481e7254b81d4ea0f66c640
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(
  lib
  var/lib
  usr/lib
)
pkg_deps=(
  core/glibc
  core/libcap
  core/lz4
  core/util-linux
  core/xz
)
pkg_svc_user=root
pkg_svc_group=root
pkg_build_deps=(
  core/coreutils
  core/dbus
  core/gcc
  core/gettext
  core/gperf
  core/m4
  core/meson
  core/ninja
  core/pkg-config
  core/patch
  core/patchelf
)

do_prepare() {
  if [[ ! -f /usr/bin/env ]]; then
    ln -s "$(pkg_path_for core/coreutils)/bin/env" /usr/bin/env
    _clean_file=true
  fi

  export LANG=en_US.utf8
  export LC_ALL=en_US.utf8
  # Systemd needs itself in rpath
  export LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/lib:${pkg_prefix}/lib/systemd"
  build_line "Setting LD_RUN_PATH=${LD_RUN_PATH}"
  LD_LIBRARY_PATH="${LD_RUN_PATH}"
  export LD_LIBRARY_PATH
  build_line "Setting LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"

  # https://github.com/systemd/systemd/commit/442bc2afee6c5f731c7b3e76ccab7301703a45a7
  # Bug with 247
  patch -p1 < "${PLAN_CONTEXT}"/patches/0001-meson-set-cxx-variable-before-using-it.patch
}

do_build() {
  # meson_options.txt
  local meson_opts=(
    "--prefix=${pkg_prefix}"
    "-Dman=false"
    "-Dhtml=false"
    "-Drootprefix=${pkg_prefix}"
    "-Drootlibdir=${pkg_prefix}/lib"
    "-Ddbuspolicydir=${pkg_prefix}/etc/dbus-1/system.d"
    "-Ddbussessionservicedir=${pkg_prefix}/etc/dbus-1/services"
    "-Ddbussystemservicedir=${pkg_prefix}/etc/dbus-1/system-services"
    "-Dtests=false"
  )
  meson build "${meson_opts[@]}"
  ninja -C build
}

do_install() {
  ninja -C build install
}

do_after() {
  unset LD_LIBRARY_PATH

  # https://github.com/mesonbuild/meson/issues/6541
  # Is meson stripping rpath here?
  find "$pkg_prefix"/bin -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -exec patchelf --force-rpath --set-rpath "${LD_RUN_PATH}" {} \;

  for lib in "${pkg_lib_dirs[@]}"; do
    find "${pkg_prefix}/${lib}" -type f -executable \
      -exec sh -c 'file -i "$1" | grep -q "x-pie-executable; charset=binary"' _ {} \; \
      -exec patchelf --force-rpath --set-rpath "${LD_RUN_PATH}" {} \;
  done
}

do_end() {
  if [[ -n "${_clean_file}" ]]; then
    rm -f /usr/bin/env
  fi
}