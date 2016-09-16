pkg_name=mongodb
pkg_origin=chefops
pkg_version=3.2.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_source=https://fastdl.mongodb.org/src/mongodb-src-r${pkg_version}.tar.gz
pkg_shasum=25f8817762b784ce870edbeaef14141c7561eb6d7c14cd3197370c2f9790061b
pkg_deps=(core/gcc-libs core/glibc)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/python2
  core/scons
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_dirname=${pkg_name}-src-r${pkg_version}

do_prepare() {
  if [[ ! -r /usr/bin/basename ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/basename" /usr/bin/basename
    _clean_basename=true
  fi

  if [[ ! -r /usr/bin/tr ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/tr" /usr/bin/tr
    _clean_tr=true
  fi
}

do_unpack() {
  do_default_unpack
  sed -i'' -e "s#chmod 755#$(pkg_path_for coreutils)/bin/chmod 755#" $pkg_dirname/src/mongo/SConscript
}

do_build() {
  CC="$(pkg_path_for gcc)/bin/gcc"
  CXX="$(pkg_path_for gcc)/bin/g++"
  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  scons --prefix="$pkg_prefix" CXX="$CXX" CC="$CC" LINKFLAGS="$LDFLAGS" SHLINKFLAGS="$LDFLAGS" --release core
}

do_check() {
  CC="$(pkg_path_for gcc)/bin/gcc"
  CXX="$(pkg_path_for gcc)/bin/g++"
  LDFLAGS="$LDFLAGS -Wl,-rpath=${LD_RUN_PATH},--enable-new-dtags"
  scons --prefix="$pkg_prefix" CXX="$CXX" CC="$CC" LINKFLAGS="$LDFLAGS" SHLINKFLAGS="$LDFLAGS" --release dbtest
  python buildscripts/resmoke.py --suites=dbtest
}

do_install() {
  CC="$(pkg_path_for gcc)/bin/gcc"
  CXX="$(pkg_path_for gcc)/bin/g++"
  scons --prefix="$pkg_prefix" CXX="$CXX" CC="$CC" LINKFLAGS="$LDFLAGS" SHLINKFLAGS="$LDFLAGS" install
}

do_end() {
  if [[ -n "$_clean_basename" ]]; then
    rm -fv /usr/bin/basename
  fi

  if [[ -n "$_clean_tr" ]]; then
    rm -fv /usr/bin/tr
  fi
}
