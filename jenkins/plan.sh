pkg_name=jenkins
pkg_origin=core
pkg_version=2.89.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The leading open source automation server, Jenkins provides hundreds of plugins to support building, deploying and automating any project."
pkg_license=('mit')
pkg_upstream_url="https://jenkins.io/"
pkg_source="http://mirrors.jenkins.io/war-stable/${pkg_version}/jenkins.war"
pkg_shasum="f9f363959042fce1615ada81ae812e08d79075218c398ed28e68e1302c4b272f"
pkg_deps=(core/jre8 core/curl)
pkg_exports=(
    [port]=jenkins.http.port
)
pkg_exposes=(port)
pkg_svc_user="root"

do_unpack() {
    return 0
}

do_build() {
    return 0
}

do_install() {
    cp "${HAB_CACHE_SRC_PATH}"/"${pkg_filename}" "${pkg_prefix}"/jenkins.war
}
