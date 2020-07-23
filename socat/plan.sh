pkg_name=socat
pkg_origin=core
pkg_version=1.7.3.3
pkg_source=http://www.dest-unreach.org/${pkg_name}/download/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=8cc0eaee73e646001c64adaab3e496ed20d4d729aaaf939df2a761e99c674372
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Multipurpose relay for bidirectional data transfer between two independent data channels"
pkg_upstream_url=http://www.dest-unreach.org/socat/
pkg_license=('GPL-2.0')
pkg_bin_dirs=(bin)
pkg_build_deps=(core/make core/gcc)
pkg_deps=(core/glibc core/readline core/openssl)

#
# TODO(ssd) 2017-06-11: The following is a summary of my attempt to
# get the test suit passing. Most tests pass; however it requires
# substantial setup and there are number of failing tests so I've left
# them disabled.
#
# The tests depend on the underlying kernel supporting the features it
# has been built with. Notably, your kernel must support SCTP for the
# SCTP tests to pass.
#
# The test suite has at least the following dependencies
#
#   core/diffutils
#   core/iproute2
#   core/net-tools (for ifconfig)
#   core/which
#   core/grep (to ensure we don't get grep from busybox)
#   core/coreutils (to ensure we don't get stat from busybox)
#   core/busybox (for ping)
#
# The tests currently hang at the following test:
#
#   test 320 UDP4MAXCHILDREN: max-children option...
#
# If you comment that test out, there are still 4-5 failing tests that
# would need to be addressed.
#
# do_prepare() {
#     if [[ ! -r /sbin/ifconfig ]]; then
#         ln -sv "$(pkg_path_for net-tools)/sbin/ifconfig" /sbin/ifconfig
#         _clean_ifconfig=true
#     fi
# }
#
# do_end() {
#     if [[ -n "$_clean_ifconfig" ]]; then
#         rm -fv /sbin/ifconfig
#     fi
# }
#
# do_check() {
#     make test
# }
