pkg_name=rsync
pkg_version=3.1.3
pkg_origin=core
pkg_license=('GPL-3.0')
pkg_description="An open source utility that provides fast incremental file transfer"
pkg_upstream_url="https://rsync.samba.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://download.samba.org/pub/${pkg_name}/src/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=55cc554efec5fdaad70de921cd5a5eeb6c29a95524c715f3bbf849235b0800c0
pkg_deps=(core/glibc core/perl core/acl core/attr)
pkg_build_deps=(core/make core/gcc core/perl core/diffutils)
pkg_bin_dirs=(bin)

#
# The tests may fail inside the studio depending on where your studio
# is hosted as some of the tests (default-acl, hardlinks, xattrs,
# xattrs-hlink) make assumptions about the capabilities of the
# underlying filesystem.
#
# In a boot2docker based studio expect default-acl and hardlinks to
# fail because of the limitations of aufs.
#
# On a machine with selinux, xattrs and xattrs-hlinks may fail because
# of the selinux context information in the extended attributes.
#
do_check() {
  make check
}
