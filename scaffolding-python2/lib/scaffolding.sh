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
# Plan Default Variables
#
pkg_bin_dirs=(${pkg_bin_dirs[@]:-"bin"})
pkg_interpreters=(bin/python)

#
# Scaffolding Variables
#

# This variable allows a user to set the habitat package name to be different
# from the package name on pypi if needed.
pkg_scaffolding_python_pip_name="${pkg_scaffolding_python_pip_name:-$pkg_name}"
# This variable allows a user to set the habitat package version to be different
# from the package version on pypi if needed.
pkg_scaffolding_python_pip_version="${pkg_scaffolding_python_pip_version:-$pkg_version}"
# Name of python package to add to the build and runtime deps.
pkg_scaffolding_python_runtime_pkg_name="core/python2"
# Default virtualenv command to use.
pkg_scaffolding_python_virtualenv_cmd="python -m virtualenv"

#
# Scaffolding Callback Functions
#

# Helper function to check for a setup.py file.
_setup_py_exists() {
  [[ -f "$SRC_PATH/setup.py" ]]
}

# The default_begin phase is executed prior to loading the scaffolding. As such
# we have a scaffolding specific callback to allow us to run anything we need
# to execute before download and build. This callback executes immediately
# after the scaffolding is loaded.
_scaffolding_load() {
  pkg_deps=(${pkg_deps[@]} $pkg_scaffolding_python_runtime_pkg_name)
  if _resolve_run_dependencies; then
    build_line "Resolved Scaffolding Runtime Dependencies"
  fi

  if [[ "$pkg_source" == "pip" ]]; then
    _scaffolding_python_pip_only="true"
  fi
}

# Attempt to retrieve values from setup.py so we can assign the return value to
# package variables.
# Accepts option names without the preceeding `--` part.
# Returns 0 for valid options.
# Returns 5 for non-existant setup.py, undefined setup parameters, or invalid
# arguments. This is so that the default `trap` does not run `_on_exit` since
# we want to check the return of this function when it is used.
_scaffolding_python_fetch_setup_info() {
  local option
  local value
  option="$1"
  if _setup_py_exists; then
    value="$(python setup.py --"$option")"
    # Python with emit a non-zero return status if setup.py does not exist, or
    # if the option passed is invalid.
    # For valid but undefined values it will return "UNKNOWN", with the
    # exception of `--version` for which it will return `0.0.0`.
    if [[ $? -ne 0 ]] || [[ "$value" == "UNKNOWN" ]] || [[ "$value" == "0.0.0" ]]; then
      return 5
    else
      printf "%s" "$value"
    fi
  fi
}

# Fetch and assign the pkg_upstream_url if it is not set in the plan, and is
# defined in the setup.py.
_scaffolding_python_setup_pkg_upstream_url() {
  local url
  url="$(_scaffolding_python_fetch_setup_info "url")"

  if [[ $? -eq 0 ]]; then
    build_line "Setting pkg_upstream_url=$url"
    pkg_upstream_url=${pkg_upstream_url:-"$url"}
  fi
}

# Fetch and assign the pkg_description if it is not set in the plan, and is
# defined in the setup.py. Attempts to use `long_description`, and falls back
# to description if `long_description` is undefined in the setup.py.
_scaffolding_python_setup_pkg_description() {
  local name
  description="$(_scaffolding_python_fetch_setup_info "long-description" || _scaffolding_python_fetch_setup_info "description")"

  if [[ $? -eq 0 ]]; then
    build_line "Setting pkg_description=$description"
    pkg_description=${pkg_description:-"$description"}
  fi
}
scaffolding_python_virtualenv() {
  local log_level
  if [[ -n "$DEBUG" ]]; then
    log_level="--vebose"
  else
    log_level="--quiet"
  fi

  # Install the virtualenv module for python2 if it is not already installed.
  if [[ ! $($pkg_scaffolding_python_virtualenv_cmd) ]]; then
    build_line "Installing virtualenv"
    pip install "$log_level" virtualenv
  fi

  if [[ ! -f "$pkg_prefix/bin/activate" ]]; then
    build_line "Creating virtualenv for hab package"
    $pkg_scaffolding_python_virtualenv_cmd \
      --python="$(pkg_interpreter_for "$pkg_scaffolding_python_runtime_pkg_name" "bin/python")" \
      "$pkg_prefix"
  fi

  if source "$pkg_prefix/bin/activate"; then
    build_line "Activated virtualenv"
  fi
}


# Attempts to automatically set various pkg_* variables.
scaffolding_python_prepare() {
  _scaffolding_python_setup_pkg_description
  _scaffolding_python_setup_pkg_upstream_url
}

# Removes bytecode and other stuff we do not need to package up.
scaffolding_python_clean() {
  if [[ $(_setup_py_exists) ]]; then
    pushd "$SRC_PATH" >/dev/null
    python setup.py clean --all
    popd >/dev/null
  else
    find "$SRC_PATH" \( -type f -name "*.pyc" -or -name "*.pyo" \) -delete
  fi
}

# Run setup.py if it exists, otherwise return so pip can do the install.
scaffolding_python_build() {
  scaffolding_python_virtualenv
  if [[ $(_setup_py_exists) ]]; then
    build_line "Running setup.py"
    "$pkg_prefix/bin/python" setup.py build --executable="$pkg_prefix/bin/python"
  else
    return 0
  fi
}

# This can be called directly to install multiple pip packages.
# Usage: `scaffolding_python_pip_install "mypackage "myversion"`
# OR `scaffolding_python_pip_install "mypackage" "myversion" "--other-pip-arg"`
scaffolding_python_pip_install() {
  local name
  local version
  local args
  name="$1"
  version="$2"
  args="${3:-"--prefix=$pkg_prefix --force-reinstall --no-compile"}"

  if [[ -n "$DEBUG" ]]; then
    args="$args -vvv"
  else
    args="$args --quiet"
  fi

  build_line "Running pip install"
  # Disable shellcheck rule to ensure the pip install command is expanded
  # with the correct syntax.
  # shellcheck disable=SC2086
  pip install $name==$version $args
  # Write out versions of all pip packages to package
  pip freeze > "$pkg_prefix/requirements.txt"
}

# Execute `setup.py install` and attempts to not create zip file eggs.
# Accepts optional argument to overide the default `install_args`.
# shellcheck disable=SC2120
scaffolding_python_setuptools_install() {
    local install_cmd
    local install_args
    install_cmd="$pkg_prefix/bin/python setup.py install"
    install_args=(${1:-"--prefix=$pkg_prefix"})

    if [[ -z "$DEBUG" ]]; then
      install_args+=("--quiet")
    else
      install_args+=("--verbose")
    fi

    $install_cmd \
      "${install_args[@]}" \
      --old-and-unmanageable || \
    $install_cmd \
      "${install_args[@]}"
}

# Attempt to install the python package via setup.py without egg files.
# We do not need the eggs since we are already keeping everything contained
# within the hab package.
scaffolding_python_install() {
  if [[ -n "$_scaffolding_python_pip_only" ]]; then
    scaffolding_python_pip_install "$pkg_scaffolding_python_pip_name" "$pkg_scaffolding_python_pip_version"
  else
    # shellcheck disable=SC2119
    scaffolding_python_setuptools_install
  fi
}

# Run do_default_strip to ensure any native C extentions are stripped.
# After this completes, we clean the bytecode since we don't need to keep it
# in the hab package and remove tests since they won't be executed at this
# stage.
scaffolding_python_strip() {
 do_default_strip
 scaffolding_python_clean

 # Remove tests from packages.
 find "$pkg_prefix" \
   \( -type d -name test -o -name tests \) \
   -exec rm -rf '{}' +
}

do_default_prepare() {
  scaffolding_python_prepare
}

do_default_build() {
  scaffolding_python_build
}

do_default_install() {
  scaffolding_python_install
}

do_strip() {
  scaffolding_python_strip
}
