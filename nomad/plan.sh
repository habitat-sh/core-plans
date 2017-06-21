pkg_name=nomad
pkg_origin=core
pkg_version=latest
pkg_source=https://github.com/hashicorp/${pkg_name}
#scaffolding_go_gopath="$CACHE_PATH"
pkg_scaffolding=core/scaffolding-go
pkg_deps=(core/coreutils core/busybox-static)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root

do_build() {
    cd $CACHE_PATH/src/github.com/hashicorp/nomad/
    make bootstrap
    fix_interpreter "scripts/*" core/coreutils bin/env
    export PATH=$PATH:$CACHE_PATH/bin
    make dev
}


do_install() {
  cp $CACHE_PATH/bin/${pkg_name} ${pkg_prefix}/bin/${pkg_name}
}
