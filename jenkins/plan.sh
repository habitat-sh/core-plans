pkg_origin=endocode
pkg_name=jenkins
pkg_version=2.46.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The leading open source automation server, Jenkins provides hundreds of plugins to support building, deploying and automating any project."
pkg_license=('mit')
pkg_upstream_url=https://jenkins.io/
pkg_source=http://mirrors.jenkins.io/war-stable/${pkg_version}/jenkins.war
pkg_shasum=33a3f4d983c6188a332291e1d974afa0a2ee96a0ae3cb6dd4f2098086525f9f1
pkg_deps=(core/tomcat8 core/jdk8)
pkg_exposes=(50000)
pkg_svc_user="root"

do_clean() {
    return 0
}

do_unpack() {
    return 0
}

do_build() {
    return 0
}

do_install() {
    local source_war="${HAB_CACHE_SRC_PATH}/${pkg_filename}"
    local webapps_dir="$(hab pkg path core/tomcat8)/tc/webapps"
    rm -rf ${webapps_dir}/*
    mv ${source_war} ${webapps_dir}/ROOT.war
}
