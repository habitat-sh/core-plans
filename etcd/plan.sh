pkg_name=etcd
pkg_description="Distributed reliable key-value store for the most critical data of a distributed system"
pkg_origin=core
pkg_version="v3.4.15"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/coreos/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}-linux-amd64.tar.gz"
pkg_upstream_url=https://github.com/coreos/etcd/
pkg_shasum=3bd00836ea328db89ecba3ed2155293934c0d09e64b53d6c9dfc0a256e724b81
pkg_dirname="${pkg_name}-${pkg_version}-linux-amd64"
pkg_deps=(core/curl)
pkg_build_deps=(core/gnupg)
pkg_bin_dirs=(/usr/bin)
pkg_exports=(
  [client-port]=etcd-client-end
  [server-port]=etcd-server-end
)
pkg_exposes=(client-port server-port)
pkg_svc_user="root"
# pkg_svc_group="$pkg_svc_user"

do_build() {
  return 0
}

do_install() {
  if [ ! -f "$pkg_prefix/etc/nsswitch.conf" ]; then
     mkdir "$pkg_prefix/etc/"
     touch "$pkg_prefix/etc/nsswitch.conf"
     echo "hosts: files dns" > "$pkg_prefix/etc/nsswitch.conf"
  fi

  mkdir -p "${pkg_prefix}/var/lib/etcd"
  install -v -D "$HAB_CACHE_SRC_PATH/$pkg_dirname/etcd" "$pkg_prefix/usr/bin/etcd"
  install -v -D "$HAB_CACHE_SRC_PATH/$pkg_dirname/etcdctl" "$pkg_prefix/usr/bin/etcdctl"
}

do_strip() {
  return 0
}
