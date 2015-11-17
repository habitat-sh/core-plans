pkg_name=nginx
pkg_derivation=chef
pkg_version=1.8.0
pkg_maintainer="Adam Jacob <adam@chef.io>"
pkg_license=('bsd')
pkg_source=http://nginx.org/download/nginx-1.8.0.tar.gz
pkg_shasum=23cca1239990c818d8f6da118320c4979aadf5386deda691b1b7c2c96b9df3d5
pkg_gpg_key=3853DA6B
pkg_deps=(chef/glibc chef/libedit chef/ncurses chef/zlib chef/bzip2 chef/openssl chef/pcre)
pkg_lib_dirs=(lib)
pkg_binary_path=(sbin)
pkg_include_dirs=(include)
pkg_service_run="sbin/nginx"
pkg_service_user="root"
pkg_docker_build="auto"
pkg_expose=(80 443)

build() {
  ./configure --prefix=$pkg_prefix \
    --conf-path="$pkg_srvc_config/nginx.conf" \
    --sbin-path="$pkg_prefix/bin/nginx" \
    --pid-path="$pkg_srvc_var/nginx.pid" \
    --lock-path="$pkg_srvc_var/nginx.lock" \
    --user=bldr \
    --group=bldr \
    --http-log-path=/dev/stdout \
    --error-log-path=stderr \
    --http-client-body-temp-path="$pkg_srvc_var/client-body" \
    --http-proxy-temp-path="$pkg_srvc_var/proxy" \
    --http-fastcgi-temp-path="$pkg_srvc_var/fastcgi" \
    --http-scgi-temp-path="$pkg_srvc_var/scgi" \
    --http-uwsgi-temp-path="$pkg_srvc_var/uwsgi" \
    --with-ipv6 \
    --with-pcre-jit \
    --with-file-aio \
    --with-http_dav_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_spdy_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_addition_module \
    --with-http_degradation_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_secure_link_module \
    --with-http_sub_module \
    --with-cc-opt="$CFLAGS" \
    --with-ld-opt="$LDFLAGS"

  make
}

install() {
  mkdir -p $pkg_prefix/sbin
  cp $BLDR_SRC_CACHE/$pkg_dirname/objs/nginx $pkg_prefix/sbin
}

