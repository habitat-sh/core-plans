pkg_name=elasticsearch
pkg_origin=core
pkg_version=2.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Revised BSD')
pkg_source=https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=23a369ef42955c19aaaf9e34891eea3a055ed217d7fbe76da0998a7a54bbe167
pkg_deps=(core/glibc core/server-jre)
pkg_bin_dirs=(es/bin)
pkg_lib_dirs=(lib)
pkg_svc_run="elasticsearch --default.path.conf=$pkg_svc_config_path"
pkg_expose=(9200 9300)

do_build() {
  return 0
}

do_install() {
  build_line "Copying files from $PWD"
  # Elasticsearch is greedy when grabbing config files from /bin/..
  # so we need to put the untemplated config dir out of reach
  install -vDm644 README.textile $pkg_prefix/share/README.textile
  install -vDm644 LICENSE.txt $pkg_prefix/share/licenses/LICENSE.txt
  install -vDm644 NOTICE.txt $pkg_prefix/share/licenses/NOTICE.txt

  mkdir -p $pkg_prefix/es
  cp -a bin lib modules $pkg_prefix/es
}
