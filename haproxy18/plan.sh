if [[ "${PWD}" = *"haproxy18"* ]]; then
  source ../haproxy/plan.sh
else
  source haproxy/plan.sh
fi

pkg_name=haproxy18
pkg_distname=haproxy
pkg_version=1.8.14
pkg_source=https://www.haproxy.org/download/1.8/src/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=b17e402578be85e58af7a3eac99b1f675953bea9f67af2e964cf8bdbd1bd3fdf
pkg_dirname="${pkg_distname}-${pkg_version}"
