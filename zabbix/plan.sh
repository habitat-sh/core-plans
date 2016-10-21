pkg_name=zabbix
pkg_origin=core
pkg_version=3.2.0
pkg_description="An open source monitoring software for networks and applications.
It is designed to monitor and track the status of various network services, servers,
and other network hardware"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source=http://downloads.sourceforge.net/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=036d1042359cb62e414d7fcf58bb09bcbf1eabfd7bc8d5dd60d0f3095765cd5c
pkg_deps=(core/gcc-libs core/glibc core/libxml2 core/libiconv core/mysql)
pkg_build_deps=(core/gcc core/make core/libxml2 core/libiconv core/mysql core/openssl core/curl)
pkg_bin=(bin sbin)
pkg_lib=(lib)
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
    ./configure --prefix="$pkg_prefix" \
                --enable-server \
                --enable-agent \
                --enable-ipv6 \
                --with-iconv-include="$(pkg_path_for core/libiconv)/bin" \
                --with-iconv-lib="$(pkg_path_for core/libiconv)/lib" \
                --with-mysql="$(pkg_path_for core/mysql)/bin/mysql_config" \
                --with-libxml2="$(pkg_path_for core/libxml2)/bin/xml2-config"
	make
}

do_end() {
	#move the database sql files to package
	mkdir -p $pkg_prefix/database/
	cp -rf $HAB_CACHE_SRC_PATH/$pkg_dirname/database/mysql $pkg_prefix/database/
}
