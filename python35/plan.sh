pkg_name=python35
pkg_distname=Python
pkg_version=3.5.10
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Python-2.0')
pkg_description="Python is a programming language that lets you work quickly \
  and integrate systems more effectively."
pkg_upstream_url="https://www.python.org"
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_source="https://www.python.org/ftp/python/${pkg_version}/${pkg_dirname}.tgz"
pkg_shasum="3496a0daf51913718a6f10e3eda51fa43634cb6151cb096f312d48bdbeff7d3a"

# Interesting situation here where 3.5.9 will compile fine and most tests
# will pass when run with `--enable-optimizaitons`, however some included
# self-signed certs used in the tests have expired. We circumvent this by
# replacing the pems in the Lib/test directory with those of a newer
# distribution
pkg_3_9_5_source="${pkg_source//$pkg_version/3.9.5}"
pkg_3_9_5_dirname="${pkg_dirname//$pkg_version/3.9.5}"
pkg_3_9_5_filename="$(basename "$pkg_3_9_5_source")"
pkg_3_9_5_shasum="e0fbd5b6e1ee242524430dee3c91baf4cbbaba4a72dd1674b90fda87b713c7ab"

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_interpreters=(bin/python bin/python3 bin/python3.5)

pkg_deps=(
  core/bzip2
  core/expat
  core/gcc-libs
  core/gdbm
  core/glibc
  core/libffi
  core/ncurses
  core/openssl
  core/readline
  core/sqlite
  core/zlib
)

pkg_build_deps=(
  core/file
  core/coreutils
  core/diffutils
  core/gcc
  core/linux-headers
  core/make
  core/util-linux
)

do_setup_environment() {
  export LDFLAGS="$LDFLAGS -lgcc_s"
}

do_download() {
  do_default_download

  download_file "$pkg_3_9_5_source" "$pkg_3_9_5_filename" "$pkg_3_9_5_shasum"
}

do_verify() {
  do_default_verify
  verify_file "$pkg_3_9_5_filename" "$pkg_3_9_5_shasum"
}

do_unpack() {
  do_default_unpack
  unpack_file "$pkg_3_9_5_filename"
}

do_prepare() {
  sed -i.bak 's/#zlib/zlib/' Modules/Setup.dist
  sed -i -re "/(SSL=|_ssl|-DUSE_SSL|-lssl).*/ s|^#||" Modules/Setup.dist

  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  # Copy the pems from 3.9.5 to Lib/test for testing
  cp ${HAB_CACHE_SRC_PATH}/${pkg_3_9_5_dirname}/Lib/test/*.pem Lib/test

  ./configure --prefix="$pkg_prefix" \
              --enable-loadable-sqlite-extensions \
              --enable-shared \
              --with-threads \
              --with-system-expat \
              --with-system-ffi \
              --with-ensurepip \
              --enable-optimizations
  make
}

do_check() {
  make test
}

do_install() {
  do_default_install

  # link pythonx.x to python for pkg_interpreters
  local minor=${pkg_version%.*}
  local major=${minor%.*}
  ln -rs "$pkg_prefix/bin/pip$minor" "$pkg_prefix/bin/pip"
  ln -rs "$pkg_prefix/bin/pydoc$minor" "$pkg_prefix/bin/pydoc"
  ln -rs "$pkg_prefix/bin/python$minor" "$pkg_prefix/bin/python"
  ln -rs "$pkg_prefix/bin/python$minor-config" "$pkg_prefix/bin/python-config"

  # Remove idle as we are not building with Tk/x11 support so it is useless
  rm -vf "$pkg_prefix/bin/idle$major"
  rm -vf "$pkg_prefix/bin/idle$minor"

  platlib=$(python -c "import sysconfig;print(sysconfig.get_path('platlib'))")
  cat <<EOF > "$platlib/_manylinux.py"
# Disable binary manylinux1(CentOS 5) wheel support
manylinux1_compatible = False
EOF
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
