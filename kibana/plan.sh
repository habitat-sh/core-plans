pkg_name=kibana
pkg_version=4.5.1
pkg_origin=core
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Kibana is an open source (Apache Licensed), browser based analytics and search dashboard for Elasticsearch. Kibana is a snap to setup and start using. Kibana strives to be easy to get started with, while also being flexible and powerful, just like Elasticsearch."
pkg_upstream_url=https://www.elastic.co/products/kibana
pkg_source=https://github.com/elastic/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=417c4757167d4fdacd04fab9738505a35ed35c687a62f8c9de5d9ec8bd861438
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(core/node)
pkg_build_deps=(core/node core/coreutils core/python2 core/make core/gcc core/git)
pkg_expose=(5601)

do_prepare() {
  # The `/usr/bin/env` path is hardcoded, so we'll add a symlink if needed.
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv $(pkg_path_for coreutils)/bin/env /usr/bin/env
    _clean_env=true
  fi
}

do_build () {
  git config --global http.sslVerify false
  npm install
}

do_install() {
  cp -R ./* $pkg_prefix/
  mkdir -p ${pkg_prefix}/bin
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
