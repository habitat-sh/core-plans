pkg_name=nomad
pkg_origin=core
pkg_version=latest
pkg_source=https://github.com/hashicorp/${pkg_name}
pkg_scaffolding=core/scaffolding-go
pkg_deps=(core/coreutils core/busybox-static core/docker)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root
pkg_exports=(
  [http_port]=ports.http
  [rpc_port]=ports.rpc
  [serf_port]=ports.serf
)
pkg_exposes=(http_port rpc_port serf_port)
pkg_binds_optional=(
  [agents]="http_port rpc_port serf_port"
  [servers]="http_port rpc_port serf_port"
)

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
