pkg_name=etcd
pkg_description="Distributed reliable key-value store for the most critical data of a distributed system"
pkg_origin=core
pkg_version=3.5.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/etcd-io/${pkg_name}/archive/refs/tags/v${pkg_version}.tar.gz"
pkg_upstream_url=https://github.com/coreos/etcd/
pkg_shasum=499c3adca699199981cd46e1267dccdd4c34bbc111fc9166dc555cbf9ca91918
pkg_deps=(core/curl)
pkg_build_deps=(
	core/gnupg
	core/coreutils
	core/go
	core/git
)
pkg_bin_dirs=(/usr/bin)
pkg_exports=(
  [client-port]=etcd-client-end
  [server-port]=etcd-server-end
)
pkg_exposes=(client-port server-port)
pkg_svc_user="root"
# pkg_svc_group="$pkg_svc_user"

do_prepare() {
	# The `/usr/bin/env` path is hardcoded, so we'll add a symlink if needed.
	if [[ ! -r /usr/bin/env ]]; then
		ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
		_clean_env=true
	fi
}

do_build() {
	./build.sh
}

do_install() {
  if [ ! -f "$pkg_prefix/etc/nsswitch.conf" ]; then
     mkdir "$pkg_prefix/etc/"
     touch "$pkg_prefix/etc/nsswitch.conf"
     echo "hosts: files dns" > "$pkg_prefix/etc/nsswitch.conf"
  fi

  mkdir -p "${pkg_prefix}/var/lib/etcd"
  install -v -D "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin/etcd" "$pkg_prefix/usr/bin/etcd"
  install -v -D "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin/etcdctl" "$pkg_prefix/usr/bin/etcdctl"
  install -v -D "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin/etcdutl" "$pkg_prefix/usr/bin/etcdutl"
}

do_strip() {
  return 0
}

do_end() {
	# Clean up the `env` link, if we set it up.
	if [[ -n "$_clean_env" ]]; then
		rm -fv /usr/bin/env
	fi
}
