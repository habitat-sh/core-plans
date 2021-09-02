pkg_name=ttyrec
pkg_description="ttyrec is a tty recorder. Recorded data can be played back with the included ttyplay command. ttyrec is just a derivative of script command for recording timing information with microsecond accuracy as well. It can record emacs -nw, vi, lynx, or any programs running on tty."
pkg_origin=core
pkg_version=1.0.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('bsd')
pkg_upstream_url="http://0xcc.net/ttyrec/"
pkg_source=http://0xcc.net/$pkg_name/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=ef5e9bf276b65bb831f9c2554cd8784bd5b4ee65353808f82b7e2aef851587ec
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils core/make core/gcc/9.1.0)
pkg_bin_dirs=(bin)

do_build() {
  make CFLAGS+="-DSVR4 -DHAVE_inotify -D_XOPEN_SOURCE=500"
}

do_install() {
  for bin in ttyplay ttyrec ttytime; do
    install -v -D $bin "${pkg_prefix}/bin/$bin"
  done
}
