pkg_name=valgrind
pkg_origin=core
pkg_version=3.17.0
pkg_description="An instrumentation framework for building dynamic analysis tools"
pkg_upstream_url="http://www.valgrind.org/"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.valgrind.org/downloads/valgrind-${pkg_version}.tar.bz2"
pkg_shasum=ad3aec668e813e40f238995f60796d9590eee64a16dff88421430630e69285a2
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/which core/diffutils core/perl)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

# From README_MAINTAINERS:
#
# > -- Don't strip the debug info off lib/valgrind/$platform/vgpreload*.so
# >  in the installation tree.  Either Valgrind won't work at all, or it
# >  will still work if you do, but will generate less helpful error
# >  messages.
#
# and
#
# > -- Don't strip symbols from lib/valgrind/* in the installation tree.
# >  Doing so will likely cause problems.  Removing the line number info is
# >  probably OK (at least for some of the files in that directory), although
# >  that has not been tested by the Valgrind developers.
#
# We also shouldn't stripping ld.so:
#
# > -- Do not ship your Linux distro with a completely stripped
# >  /lib/ld.so.  At least leave the debugging symbol names on -- line
# >  number info isn't necessary.
#
# The current version in the depot isn't stripped, but that will
# likely change in the future if it is rebuilt with a newer version of
# hab.
#
do_strip() {
  build_line "Skipping symbol stripping"
}

do_check() {
  make check
}
