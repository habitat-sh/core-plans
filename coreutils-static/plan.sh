source ../coreutils/plan.sh

pkg_name=coreutils-static
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Core Utilities are the basic file, shell and text manipulation \
utilities of the GNU operating system. These are the core utilities which are \
expected to exist on every operating system.\
"
pkg_upstream_url="https://www.gnu.org/software/coreutils/"
pkg_license=('GPL-3.0')
pkg_dirname=${_distname}-${pkg_version}

# Throw the run deps into build deps as this will be static
pkg_build_deps=(
  "${pkg_deps[@]}"
  "${pkg_build_deps[@]}"
)
# Empty out the run deps array
pkg_deps=()

do_prepare() {
  PLAN_CONTEXT=$PLAN_CONTEXT/../coreutils _patch_files
}

do_build() {
  # Uses the `--enable-single-binary` flag to build a single binary file
  # (`coreutils`) which contains all tools in it.
  #
  # Thanks to: https://lists.gnu.org/archive/html/coreutils/2014-06/msg00036.html
  FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix="$pkg_prefix" \
    --enable-single-binary \
    LDFLAGS="-static $LDFLAGS"
  make
}

# We will rely on tests from `coreutils`, so skip them here
unset -f do_check
