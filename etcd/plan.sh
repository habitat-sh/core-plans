pkg_name=etcd
pkg_description="Distributed reliable key-value store for the most critical data of a distributed system"
pkg_origin=core
pkg_version="v3.1.5"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source=https://github.com/coreos/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}-linux-amd64.tar.gz
pkg_upstream_url=https://github.com/coreos/etcd/releases/
pkg_shasum=812f2a8e28330cb1e127177ff81efaa24f8e57ce22d3cd28799ef1f939f71454
pkg_dirname=${pkg_name}-${pkg_version}-linux-amd64
pkg_deps=()
pkg_build_deps=(core/gnupg)
pkg_bin_dirs=(/usr/bin)

pkg_exports=(
  [client-port]=etcd-client-end
  [server-port]=etcd-server-end
)

pkg_exposes=(client-port server-port)

pkg_svc_user="root"

# pkg_svc_group="$pkg_svc_user"

do_download() {
  do_default_download

  download_file "https://github.com/coreos/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}-linux-amd64.tar.gz.asc" \
	        "${pkg_name}-${pkg_version}-linux-amd64.tar.gz.asc" \
  		"f6ef73ff5b8e70313c0ff759cd9dcb86974e95882dff3b9c762342d568a08121"
  download_file "https://coreos.com/dist/pubkeys/app-signing-pubkey.gpg" \
	        "app-signing-pubkey.gpg" \
                "16b93904e4b3133fe4b5f95f46e3db998c3b2f9d9cee6d4c2eb531f98028bcb3"
}

do_verify() {
  do_default_verify

  verify_file "${pkg_name}-${pkg_version}-linux-amd64.tar.gz.asc" \
	      "f6ef73ff5b8e70313c0ff759cd9dcb86974e95882dff3b9c762342d568a08121"
  verify_file "app-signing-pubkey.gpg" \
	      "16b93904e4b3133fe4b5f95f46e3db998c3b2f9d9cee6d4c2eb531f98028bcb3"

  # GPG verification
  build_line "Verifying ${pkg_name}-${pkg_version}-linux-amd64.tar.gz signature"
  export GNUPGHOME="$(mktemp -d -p $HAB_CACHE_SRC_PATH)"
  gpg --import --keyid-format LONG "${HAB_CACHE_SRC_PATH}/app-signing-pubkey.gpg"
  gpg --batch --verify \
	${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}-linux-amd64.tar.gz.asc \
        ${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}-linux-amd64.tar.gz
  rm -r "$GNUPGHOME"
  build_line "Signature verified for ${pkg_name}-${pkg_version}-linux-amd64.tar.gz"
}

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
