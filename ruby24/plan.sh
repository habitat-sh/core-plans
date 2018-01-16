source ../ruby/plan.sh

pkg_name=ruby24
pkg_dirname="ruby-$pkg_version"

if ! [[ "$pkg_version" =~ ^2.4 ]]; then
  build_line "ERROR: This plan is intended to build v2.4.x but its sourced plan version is $pkg_version"
  exit 1
fi
