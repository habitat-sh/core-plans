pkg_name=telegraf
pkg_origin=core
pkg_version="1.3.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('The MIT License (MIT)')
pkg_description="telegraf - client for InfluxDB"
pkg_upstream_url="https://github.com/influxdata/telegraf/"
pkg_scaffolding="core/scaffolding-go"
pkg_svc_run="bin/telegraf"
pkg_bin_dirs=(bin)

do_begin() {
    set -x
    export GOBIN="${GOPATH}/bin"
}

do_download() {
    git clone --branch "${pkg_version}" https://github.com/influxdata/telegraf || true
    cd telegraf && \
        git pull origin $pkg_version
}

do_build() {
    go get github.com/influxdata/telegraf
    cd "$GOPATH"/src/github.com/influxdata/telegraf || exit
    make
}

do_install() {
    mkdir -p "${pkg_prefix}"/bin
    cp /bin/telegraf "${pkg_prefix}"/bin
}

do_clean() {
    return 0
}
