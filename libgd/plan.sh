pkg_name=libgd
pkg_origin=core
pkg_version="2.3.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=($(cat << EOF
In order to resolve any possible confusion regarding the authorship of
gd, the following copyright statement covers all of the authors who
have required such a statement. If you are aware of any oversights in
this copyright notice, please contact Pierre-A. Joye who will be
pleased to correct them.

   Portions copyright 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001,
   2002, 2003, 2004 by Cold Spring Harbor Laboratory. Funded under
   Grant P41-RR02188 by the National Institutes of Health.

   Portions copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
   2004 by Boutell.Com, Inc.

   Portions relating to GD2 format copyright 1999, 2000, 2001, 2002,
   2003, 2004 Philip Warner.

   Portions relating to PNG copyright 1999, 2000, 2001, 2002, 2003,
   2004 Greg Roelofs.

   Portions relating to gdttf.c copyright 1999, 2000, 2001, 2002,
   2003, 2004 John Ellson (ellson@graphviz.org).

   Portions relating to gdft.c copyright 2001, 2002, 2003, 2004 John
   Ellson (ellson@graphviz.org).

   Portions copyright 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007
   Pierre-Alain Joye (pierre@libgd.org).

   Portions relating to JPEG and to color quantization copyright
   2000, 2001, 2002, 2003, 2004, Doug Becker and copyright (C) 1994,
   1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004 Thomas
   G. Lane. This software is based in part on the work of the
   Independent JPEG Group. See the file README-JPEG.TXT for more
   information.

   Portions relating to GIF compression copyright 1989 by Jef
   Poskanzer and David Rowley, with modifications for thread safety
   by Thomas Boutell.

   Portions relating to GIF decompression copyright 1990, 1991, 1993
   by David Koblas, with modifications for thread safety by Thomas
   Boutell.

   Portions relating to WBMP copyright 2000, 2001, 2002, 2003, 2004
   Maurice Szmurlo and Johan Van den Brande.

   Portions relating to GIF animations copyright 2004 Jaakko Hyvätti
   (jaakko.hyvatti@iki.fi)

Permission has been granted to copy, distribute and modify gd in
any context without fee, including a commercial application,
provided that this notice is present in user-accessible supporting
documentation.

This does not affect your ownership of the derived work itself,
and the intent is to assure proper credit for the authors of gd,
not to interfere with your productive use of gd. If you have
questions, ask. "Derived works" includes all programs that utilize
the library. Credit must be given in user-accessible
documentation.

This software is provided "AS IS." The copyright holders disclaim
all warranties, either express or implied, including but not
limited to implied warranties of merchantability and fitness for a
particular purpose, with respect to this code and accompanying
documentation.

Although their code does not appear in the current release, the
authors also wish to thank Hutchison Avenue Software Corporation
for their prior contributions.
EOF
))
pkg_source="https://github.com/$pkg_name/$pkg_name/releases/download/gd-$pkg_version/$pkg_name-$pkg_version.tar.xz"
pkg_shasum=478a047084e0d89b83616e4c2cf3c9438175fb0cc55d8c8967f06e0427f7d7fb
pkg_deps=(
  core/fontconfig
  core/freetype
  core/libjpeg-turbo
  core/libpng
  core/libtiff
  core/zlib
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/make
  core/pkg-config
  core/bzip2
  core/jbigkit
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="GD is an open source code library for the dynamic creation of images by programmers."
pkg_upstream_url="https://libgd.github.io"

do_prepare() {
  if [ ! -e /usr/bin/file ]
  then
    ln -sv "$(pkg_path_for core/file)/bin/file" /usr/bin/file
  fi
}

do_check() {
  LD_LIBRARY_PATH="${LD_RUN_PATH}:$(pkg_path_for bzip2)/lib:$(pkg_path_for jbigkit)/lib"
  export LD_LIBRARY_PATH
  # Failure: https://github.com/libgd/libgd/issues/367
  make check
}

do_end() {
  if [ -e /usr/bin/file ]
  then
    rm /usr/bin/file
  fi
}
