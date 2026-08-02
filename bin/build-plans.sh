#!/bin/bash
#
# # License and Copyright
#
# ```
# Copyright: Copyright (c) 2015-2025 Progress Software Corporation and/or its subsidiaries or affiliates. All Rights Reserved.
# License: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ```
#
#

# # Internals

# Fail if there are any unset variables and whenever a command returns a
# non-zero exit code.
set -eu

# If the variable `$DEBUG` is set, then print the shell commands as we execute.
if [ -n "${DEBUG:-}" ]; then
  set -x
fi

# ## Default variables

program="$(basename "$0")"
# The build command to execute. Defaults to `build`, but could be overridden if
# a full path to `hab-plan-build` is required.
: "${BUILD:=build}"
# The root path of the Habitat file system. If the `$HAB_ROOT_PATH` environment
# variable is set, this value is overridden, otherwise it is set to its default
: "${HAB_ROOT_PATH:=/hab}"
# Location containing installed packages.
HAB_PKG_PATH="$HAB_ROOT_PATH/pkgs"
# The path to the print deps program
print_deps_cmd="${0%/*}/print-deps.sh"


# ## Private/Internal helper functions

# **Internal** Prints help and usage information. Straight forward, no?
_print_help() {
  echo "$program

The Habitat Maintainers <humans@habitat.sh>

Builds a set of Plans and maintains a lightweight database so the same input
set can be resumed to make forward progress.

USAGE:
    $program [FLAGS] [<INPUT_FILE>]

FLAGS:
    -h, --help       Prints help information

ARGS:
    <INPUT_FILE>     A file containing a directory path containing a plan.sh
                     with one entry per line. When argument is not present,
                     input is read on standard in.
"
}

# **Internal** Handles exiting the program on signals. Takes either an argument
# with the status code, or uses the last command's status code.
#
# For example, the following would both exit with a status of 1:
#
# ```bash
# _on_exit 1
# ```
#
# Or:
#
# ```bash
# false
# _on_exit
# ```
_on_exit() {
  local exit_status=${1:-$?}
  if [ -n "${PRINT_IDENTS_ONLY:-}" ]; then
    exit $?
  fi
  local elapsed=$SECONDS
  elapsed=$(echo $elapsed | awk '{printf "%dm%ds", $1/60, $1%60}')
  # shellcheck disable=SC2059
  printf -- "\n$(basename "$0") run time: $elapsed\n\n"
  if [ "$exit_status" -ne 0 ]; then echo "Exiting on error"; fi
  exit $?
}
# Call the `on_exit()` function above on the following signals:
#
# * HUP (1)
# * INT (2)
# * QUIT (3)
# * TERM (15)
# * ERR - when a shell command raises an error. Useful for `set -e; set -E`.
trap _on_exit 1 2 3 15 ERR


# Since we have to execute inside the same studio for every build as part of
# a refresh (nothing from the outside) _or_ eat the pain of installing every
# package built previously for each build which would take an unreasonable 
# amount of time, we'll elect to clean up any cruft a previous build left 
# behind that might fail a subsequent build. A lot of tools will write to 
# /root/.directory so this gives us a convenient place to encode what needs
# to be cleaned
_clean_studio() {
  local cleanup_items=(
    /hab/cache/src
    /root/.bundle
    /root/.cabal
    /root/.cache
    /root/.cargo
    /root/.cmake
    /root/.composer
    /root/.config
    /root/.cpan
    /root/.cpanm
    /root/.drush
    /root/.gemrc
    /root/.gitconfig
    /root/.glide
    /root/.gnupg
    /root/.m2
    /root/.magefile
    /root/.mavengem
    /root/.mono
    /root/.node-gyp
    /root/.noderc
    /root/.npm
    /root/.npmrc
    /root/.v8flags.*.json
  )

  for cruft in "${cleanup_items[@]}"; do 
    rm -rf $cruft
  done
}

# Executes a build on a Plan, assuming that it has not already been built by a
# previous execution of this program. A very simple, plaintext database is
# maintained to track every Plan that has successfully completed so that if a
# Plan in the middle fails, a developer need only fix the failing Plan, and
# re-run the program--not needed to start from sqaure one. The database is
# `tmp/build-plans.db` by default so deleting this file simply removes its
# build "memory".
#
# ```sh
# _build gcc
# _build coreutils EXTRA=vars FOR=command
# ```
_build() {
  local prj_dir plan_sh pkg_ident pkg_name
  prj_dir="${1}"
  shift
  if [[ -f "$prj_dir/plan.sh" ]]; then
    plan_sh="$prj_dir/plan.sh"
  elif [[ -f "$prj_dir/habitat/plan.sh" ]]; then
    plan_sh="$prj_dir/habitat/plan.sh"
  else
    >&2 echo "Missing plan.sh in: $prj_dir, something is wrong, aborting"
    exit 10
  fi
  pkg_ident="$("$print_deps_cmd" "$plan_sh" | head -n 1)"
  pkg_name="$(echo "$pkg_ident" | cut -d '/' -f 2)"

  if [ -n "${PRINT_IDENTS_ONLY:-}" ]; then
    echo "$pkg_ident"
    return 0
  fi
  # If the `$STOP_BEFORE` environment variable is set, and its value is the
  # desired Plan, then we'll stop. This is a convenient way to build up to an
  # interesting Plan without steamrolling right over it.
  if [ "${STOP_BEFORE:-}" = "$pkg_name" ]; then
    echo "STOP_BEFORE=$STOP_BEFORE set, stopping before $pkg_name. Cheers ;)"
    exit 0
  fi
  local db="tmp/${DB_PREFIX:-}build-plans.db"
  local path="$HAB_PKG_PATH/$pkg_ident"
  local ident
  local cmd
  mkdir -p "$(dirname "$db")"
  touch "$db"

  # Check if the requested Plan exists in the database, meaning that this
  # program has previously built it.
  if grep -q "^$pkg_ident:$*$" "$db" > /dev/null; then
    # If a fully extracted/installed package exists on disk under
    # `$HAB_PKG_PATH`. We're using the `IDENT` metadata file as a sentinel
    # file stand-in for the package.
    if ident=$(find "$path" -name IDENT -type f 2>&1); then
      ident="$(echo "$ident" | tr ' ' '\n' | sort | tail -n 1)"
      # If the package's `IDENT` file is missing, something has gone wrong, die
      # early.
      if [ ! -f "$ident" ]; then
        >&2 echo "[$pkg_ident] Missing file $ident, something is wrong, aborting"
        exit 1
      fi
      # If all else is good, we should be able to count on this previously
      # built and installed package, so we will early return from this
      # function.
      echo "[$pkg_ident] Previous build found in db $db, skipping ($(cat "$ident"))"
      return 0
    else
      # If the entry exists in the database, but we can't find it installed on
      # disk, something is up and so we'll die early.
      >&2 echo "[$pkg_ident] Found in db $db but missing on disk, aborting"
      exit 2
    fi
  fi

  # If we made it here, we're going to build. Clean things up first.
  _clean_studio

  # If extra args are passed to this function, we will treat them all as
  # environment variables.
  if [ -n "$*" ]; then
    cmd="env $* $BUILD $prj_dir"
  else
    cmd="$BUILD $prj_dir"
  fi
  echo "[$pkg_ident] Building with: $cmd"
  eval "$cmd"
  # Record the successful build into our simple database
  echo "[$pkg_ident] Recording build record in $db"
  echo "$pkg_ident:$*" >> "$db"
}


# # Main Flow

# Read a list of tokens that are directories containing a `plan.sh` file. For
# each token, invoke the `_build` function and pass the while line in. Simple,
# no?

if [[ -z "${1:-}" ]]; then
  # If no arguments were provided, read the input on stdin
  echo "Reading input on stdin..."
  # shellcheck disable=SC2086
  while read -r plan; do echo "" | _build $plan; done
else
  case "$1" in
    --help|-h)
      _print_help
      exit 0
      ;;
    -*)
      >&2 echo "Invalid argument: $1, aborting"
      _print_help
      exit 1
      ;;
    *)
      if [[ ! -f "$1" ]]; then
        >&2 echo "No input file found: $1, aborting"
        exit 9
      fi
      # shellcheck disable=SC2086,SC2002
      cat "$1" | while read -r plan; do _build $plan; done
      ;;
  esac
fi

_on_exit 0
