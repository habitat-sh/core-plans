pkg_name=mongodb
pkg_origin=core
pkg_version=3.2.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_source=http://downloads.mongodb.org/src/${pkg_name}-src-r${pkg_version}.tar.gz
pkg_shasum=25f8817762b784ce870edbeaef14141c7561eb6d7c14cd3197370c2f9790061b
pkg_filename=${pkg_name}-src-r${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-src-r${pkg_version}
pkg_deps=(core/gcc-libs core/glibc core/openssl)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/glibc
  core/patchelf
  core/python2
  core/scons
  core/openssl
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_svc_user=root
pkg_svc_group=root

do_prepare() {
    #WARNING:this build takes around 1 hour and 30 minutes to complete on
    #        a macbook pro with an i5 and 8 GB RAM

    #created a variable for our compilers
    export CC="$(pkg_path_for gcc)/bin/gcc"
    export CXX="$(pkg_path_for gcc)/bin/g++"

    #create variables for our include and library pathes in a scons friendly format
    INCPATH=$(echo "$CFLAGS" | sed -e "s@-I@@g")
    export INCPATH=$(echo "$INCPATH" | sed -e "s@ @', '@g")
    LIBPATH=$(echo "$LDFLAGS" | sed -e "s@-L@@g")
    export LIBPATH=$(echo "$LIBPATH" | sed -e "s@ @', '@g")

    #because scons dislikes saving our variables
    #we will save our variables within the construct ourselves
    sed -i "836s@**envDict@ENV = os.environ, CPPPATH = ['$INCPATH'], LIBPATH = ['$LIBPATH'], CFLAGS = os.environ['CFLAGS'], CXXFLAGS = os.environ['CXXFLAGS'], LINKFLAGS = os.environ['LDFLAGS'], CC = os.environ['CC'], CXX = os.environ['CXX'], PATH = os.environ['PATH'], **envDict@g" SConstruct
}

do_build() {
    scons core --prefix="$pkg_prefix" --ssl
}

do_check() {
    scons dbtest --prefix="$pkg_prefix" --ssl
    python buildscripts/resmoke.py --suites=dbtest
}

do_install() {
    scons install --prefix="$pkg_prefix" --ssl
}
