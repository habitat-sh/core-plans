#
# DO NOT OVERRIDE `do_default_xxxxx` IN PLANS!
#

#
# Internal functions. Do not use these in your plans as they can change.
#

# _example() {
#   return 127
# }

#
# Scaffolding Variables
#

scaffolding_python2_pkg="core/python2"

#
# Scaffolding Callback Functions
#

# The default_begin phase is executed prior to loading the scaffolding. As such
# we have a scaffolding specific callback to allow us to run anything we need
# to execute before download and build. This callback executes immediately
# after the scaffolding is loaded.
_scaffolding_begin() {
  pkg_deps=(${pkg_deps[@]} $scaffolding_python2_pkg)
}


# Recursively clean GOPATH and dependencies.
do_default_clean() {
  scaffolding_python2_clean
}

scaffolding_python2_clean() {
  pushd "$pkg_dirname"
  if [[ -f "setup.py" ]]; then
    python setup.py clean --all
  else
    find . \( -type f -name "*.pyc" -or -name "*.pyo" \) -delete
  fi
  popd
}

scaffolding_python2_build() {
  python setup.py build
}

scaffolding_python2_pip_install() {
  local name
  local version
  name="$1"
  version="$2"

  pip install "$name==$version"
}

scaffolding_python2_install() {
  if [[ -f "${pkg_dirname}/setup.py" ]]; then
    python setup.py install \
      --prefix="$pkg_prefix"
  fi
}

scaffolding_python2_strip() {
 do_default_strip
 scaffolding_python2_clean

 # Remove tests from packages.
 find "$pkg_prefix" \
   \( -type d -name test -o -name tests \) \
   -exec rm -rf '{}' +
}

do_default_build() {
  scaffolding_python2_build
}

do_default_install() {
  scaffolding_python2_install
}

do_strip() {
  scaffolding_python2_strip
}
