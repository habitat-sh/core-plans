if [[ "${PWD}" = *"haproxy16"* ]]; then
  source ../haproxy/plan.sh
else
  source haproxy/plan.sh
fi

pkg_name=haproxy16
pkg_distname=haproxy
pkg_version=1.6.14
pkg_source=https://www.haproxy.org/download/1.6/src/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=bac949838a3a497221d1a9e937d60cba32156783a216146a524ce40675b6b828
pkg_dirname="${pkg_distname}-${pkg_version}"
