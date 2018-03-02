#!/bin/bash
#
# # Usage
#
# ```sh
# $ build-base-plans.sh
# ```
#
# # Synopsis
#
# Builds a set of foundational base Plans comprising a fully bootstrapped Bldr
# environment which can be used to build additional software. The build order
# is very similiar to the Linux From Scratch project, and not by accident.
#
# # License and Copyright
#
# ```
# Copyright: Copyright (c) 2016 Chef Software, Inc.
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

# The build command to execute. Defaults to `build`, but could be overridden if
# a full path to `hab-plan-build` is required.
: "${BUILD:=build}"
# The root path of the Habitat file system. If the `$HAB_ROOT_PATH` environment
# variable is set, this value is overridden, otherwise it is set to its default
: "${HAB_ROOT_PATH:=/hab}"
# Location containing installed packages.
HAB_PKG_PATH="$HAB_ROOT_PATH/pkgs"
# The default package origin which was used to in the base Plans
origin=core


# ## Private/Internal helper functions

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

# Executes a build on a Plan, assuming that it has not already been built by a
# previous execution of this program. A very simple, plaintext database is
# maintained to track every Plan that has successfully completed so that if a
# Plan in the middle fails, a developer need only fix the failing Plan, and
# re-run the program--not needed to start from sqaure one. The database is
# `tmp/build-base-plans.db` by default so deleting this file simply removes its
# build "memory".
#
# ```sh
# _build gcc
# _build coreutils EXTRA=vars FOR=command
# ```
_build() {
  local plan_dir plan
  plan_dir="${1:-}"
  plan="$(basename "$plan_dir")"
  shift
  # If the `$plan` value is a path/name combination like
  # `../components/foobar:hab-foobar` then split the token into its requisite
  # parts.
  # shellcheck disable=SC2126
  case $(echo "$plan" | grep -o ':' | wc -l | sed 's,^[^0-9]*,,') in
    1)
      plan_dir=$(echo "$plan_dir" | cut -d ':' -f 1)
      plan=$(echo "$plan" | cut -d ':' -f 2)
      ;;
  esac
  if [ -n "${PRINT_IDENTS_ONLY:-}" ]; then
    echo "${origin}/$plan"
    return 0
  fi
  # If the `$STOP_BEFORE` environment variable is set, and its value is the
  # desired Plan, then we'll stop. This is a convenient way to build up to an
  # interesting Plan without steamrolling right over it.
  if [ "${STOP_BEFORE:-}" = "$plan" ]; then
    echo "STOP_BEFORE=$STOP_BEFORE set, stopping before $plan. Cheers ;)"
    exit 0
  fi
  local db="tmp/${DB_PREFIX:-}build-base-plans.db"
  local path="$HAB_PKG_PATH/$origin/$plan"
  local manifest
  local ident
  local cmd
  mkdir -p "$(dirname "$db")"
  touch "$db"

  # Check if the requested Plan exists in the database, meaning that this
  # program has previously built it.
  if grep -q "^$origin/$plan:$*$" "$db" > /dev/null; then
    # If a fully extracted/installed package exists on disk under
    # `$HAB_PKG_PATH`. We're using the `IDENT` metadata file as a sentinel
    # file stand-in for the package.
    if ident=$(find "$path" -name IDENT -type f 2>&1); then
      ident="$(echo "$ident" | tr ' ' '\n' | sort | tail -n 1)"
      # If the package's `IDENT` file is missing, something has gone wrong, die
      # early.
      if [ ! -f "$ident" ]; then
        >&2 echo "[$plan] Missing file $ident, something is wrong, aborting"
        exit 1
      fi
      # If all else is good, we should be able to count on this previsouly
      # built and installed package, so we will early return from this
      # function.
      echo "[$plan] Previous build found in db $db, skipping ($(cat "$ident"))"
      return 0
    else
      # If the entry exists in the database, but we can't find it installed on
      # disk, something is up and so we'll die early.
      >&2 echo "[$plan] Found in db $db but missing on disk, aborting"
      exit 2
    fi
  fi

  # If extra args are passed to this function, we will treat them all as
  # environment variables.
  if [ -n "$*" ]; then
    cmd="env $* $BUILD $plan_dir"
  else
    cmd="$BUILD $plan_dir"
  fi
  echo "[$plan] Building with: $cmd"
  eval "$cmd"
  # Record the successful build into our simple database
  echo "[$plan] Recording build record in $db"
  echo "$origin/$plan:$*" >> "$db"
}


# # Main Flow

# Read a list of tokens that are directories containing a `plan.sh` file. For
# each token, invoke the `_build` function and pass the while line in. Simple,
# no?
# shellcheck disable=SC2162,SC2086
cat <<_PLANS_ | while read plan; do _build $plan; done
  core-plans/linux-headers
  core-plans/glibc
  core-plans/zlib
  core-plans/file
  core-plans/binutils
  core-plans/m4
  core-plans/gmp
  core-plans/mpfr
  core-plans/libmpc
  core-plans/gcc
  core-plans/patchelf FIRST_PASS=true
  core-plans/gcc-libs
  core-plans/patchelf
  core-plans/bzip2
  core-plans/pkg-config
  core-plans/ncurses
  core-plans/attr
  core-plans/acl
  core-plans/libcap
  core-plans/sed
  core-plans/shadow
  core-plans/psmisc
  core-plans/procps-ng
  core-plans/coreutils
  core-plans/bison
  core-plans/flex
  core-plans/pcre
  core-plans/grep
  core-plans/readline
  core-plans/bash
  core-plans/bc
  core-plans/tar
  core-plans/gawk
  core-plans/libtool
  core-plans/gdbm
  core-plans/expat
  core-plans/db
  core-plans/inetutils
  core-plans/iana-etc
  core-plans/less
  core-plans/perl
  core-plans/diffutils
  core-plans/autoconf
  core-plans/automake
  core-plans/findutils
  core-plans/xz
  core-plans/gettext
  core-plans/gzip
  core-plans/make
  core-plans/patch
  core-plans/texinfo
  core-plans/util-linux
  core-plans/tcl
  core-plans/expect
  core-plans/dejagnu
  core-plans/check
  core-plans/libidn
  core-plans/cacerts
  core-plans/openssl
  core-plans/wget
  core-plans/unzip
  core-plans/rq
  core-plans/linux-headers-musl
  core-plans/musl
  core-plans/busybox-static
  core-plans/zlib-musl
  core-plans/bzip2-musl
  core-plans/xz-musl
  core-plans/libsodium-musl
  core-plans/openssl-musl
  core-plans/libarchive-musl
  core-plans/rust
  habitat/components/hab:hab
  core-plans/bats
  habitat/components/plan-build:hab-plan-build
  core-plans/vim
  core-plans/libbsd
  core-plans/clens
  core-plans/mg
  habitat/components/backline:hab-backline
  habitat/components/studio:hab-studio
_PLANS_

_on_exit 0
