#!/bin/bash
#
# Usage: bin/check-bins.sh PACKAGE
#
# Finds any executable or library files that are missing essential #
# dependencies. PACKAGE can be a directory to a package directory or a
# fully-qualified ident of an installed package.
#
set -euo pipefail

_header_printed=""

error() {
    echo "$@" >&2
}

usage() {
    error "Usage: $0 PACKAGE"
    error ""
    error "PACKAGE is a fully-qualified ident or the path to the packages install dir."
}

check_file() {
    local dir="$1"
    local file="$2"
    local dep_file="$dir/DEPS"

    local ret=0
    local _header_printed="false"

    #
    # We are looking for a line that looks like this:
    #
    #     0x000000000000000f (RPATH)              Library rpath: [/hab/pkgs/core/glibc/2.27/20190115002733/lib:/hab/pkgs/core/pcre/8.42/20190115012526/lib]
    #
    # TODO(ssd) 2020-04-29: We could also check that all members of
    # the RPATH are in DEPS
    if ! readelf -d "$file" | grep -E "(RPATH|RUNPATH)" >/dev/null 2>&1; then
        if [[ "${_header_printed}" != "true" ]]; then
            error "$file:"
            _header_printed="true"
        fi
        error "      warning: no RPATH set, resolved libraries might not be trustworthy"
    fi

    local interp
    local interp_pkg
    local interp_error=""

    # We are looking for a line that looks like this:
    #
    #       [Requesting program interpreter: /hab/pkgs/core/glibc/2.27/20190115002733/lib/ld-linux-x86-64.so.2]
    #
    # and turning it into this:
    #
    #       /hab/pkgs/core/glibc/2.27/20190115002733/lib/ld-linux-x86-64.so.2
    #
    # not all files we are checking will have an interpreter.
    #
    interp=$(readelf -l "$file" | awk -F: '/interpreter: / {print $2}' | sed -e 's/]$//' -e 's/^ //')
    if [[ -n "$interp" ]]; then
       if [[ ! "$interp" =~ /hab/pkg.* ]]; then
           interp_error="$interp not in /hab/pkgs"
       fi

       interp_pkg=$(echo "$interp" | cut -d/ -f4-7)
       if ! grep "^${interp_pkg}\$" "$dep_file" >/dev/null 2>&1; then
           interp_error="$interp_pkg needed by interperter ($interp) but not present in $dep_file"
       fi

       if [[ -n "$interp_error" ]]; then
           ret=1
           if [[ "${_header_printed}" != "true" ]]; then
               error "$file:"
               _header_printed="true"
           fi
           error "      $interp_error"
       fi
    fi

    # ldd is a script that executes the dynamic linker with some
    # environment variables set. In cases where our interpreter is
    # different from the one ldd users, it can produce
    # false-positives.
    #
    # So, if we have an interpreter and it looks like ld, we just
    # execute it directly with the environment variables set.
    local ldd_output
    if [[ "$interp" =~ .*ld-linux-.*.so.2 ]]; then
        ldd_output=$(LD_TRACE_LOADED_OBJECTS=1 "$interp" "$file")
    else
        ldd_output=$(ldd "$file")
    fi

    missing_libs=$(echo "$ldd_output" | awk '/not found/ {print $1}' | sort | uniq)
    if [[ -n "$missing_libs" ]]; then
        ret=1
        if [[ "${_header_printed}" != "true" ]]; then
            error "$file:"
            _header_printed="true"
        fi

        for lib in $missing_libs; do
            error "      $lib missing"
        done
    fi

    #
    # Our ldd output looks like this:
    #
    # 	linux-vdso.so.1 (0x00007ffc10933000)
    #   libpcre.so.1 => /hab/pkgs/core/pcre/8.42/20190115012526/lib/libpcre.so.1 (0x00007fdf7dfb1000)
    #   libc.so.6 => /hab/pkgs/core/glibc/2.27/20190115002733/lib/libc.so.6 (0x00007fdf7ddf9000)
    #   libpthread.so.0 => /hab/pkgs/core/glibc/2.27/20190115002733/lib/libpthread.so.0 (0x00007fdf7ddd9000)
    #   /hab/pkgs/core/glibc/2.27/20190115002733/lib/ld-linux-x86-64.so.2 => /hab/pkgs/core/glibc/2.27/20190115002733/lib64/ld-linux-x86-64.so.2 (0x00007fdf7e03c000)
    #
    # Which we want to transform into
    #
    #   /hab/pkgs/core/pcre/8.42/20190115012526/lib/libpcre.so.1
    #   /hab/pkgs/core/glibc/2.27/20190115002733/lib/libc.so.6
    #   /hab/pkgs/core/glibc/2.27/20190115002733/lib/libpthread.so.0
    #   /hab/pkgs/core/glibc/2.27/20190115002733/lib64/ld-linux-x86-64.so.2
    #
    # and then
    #
    #   core/pcre/8.42/20190115012526
    #   core/glibc/2.27/20190115002733
    #
    # We want to check for resolved libs that aren't in rooted in
    # /hab/pkgs and ensure that all referenced packages are in in DEPS
    # file.
    resolved_libs=$(echo "$ldd_output" | awk '/ => / {print $3}')
    non_hab_libs=$(echo "$resolved_libs" | grep -v '^/hab/pkgs')
    if [[ -n "$non_hab_libs" ]]; then
        ret=1
        if [[ "${_header_printed}" != "true" ]]; then
            error "$file:"
            _header_printed="true"
        fi
        for lib in $non_hab_libs; do
            error "      $lib is not in /hab/pkgs"
        done
    fi

    referenced_packages=$(echo "$resolved_libs" | cut -d/ -f4-7 | sort | uniq)
    if [[ -n "$referenced_packages" ]]; then
        for pkg in $referenced_packages; do
            if grep "^${pkg}\$" "$dep_file" >/dev/null 2>&1; then
                continue
            fi
            ret=1
            if [[ "${_header_printed}" != "true" ]]; then
                error "$file:"
                _header_printed="true"
            fi
            error "      $pkg is not listed in $dep_file but is used as a dependency"
        done
    fi

    return $ret
}

should_check() {
    if [[ ! -x "$1" ]]; then
        return 1
    fi

    case "$(file -bi "$1")" in
        *application/x-*executable*) return 0;;
        *application/x-*sharedlib*) return 0;;
        *application/x-*archive*) return 0;;
        *) return 1;;
    esac
}

check_files() {
    local dir="$1"

    local resolved_dir
    local files

    if [[ ! -f "$dir/FILES" ]]; then
        if [[ -f "/hab/pkgs/$dir/FILES" ]]; then
            resolved_dir="/hab/pkgs/$dir"
        else
            error "could not find FILES manifest for $dir"
            return 1
        fi
    else
        resolved_dir="$dir"
    fi
    files="$resolved_dir/FILES"


    local ret_code=0
    while read -r f; do
        if should_check "$f"; then
            if ! check_file "$resolved_dir" "$f"; then
                ret_code=1
            fi
        fi
    done <<< "$(awk '{if (NR > 5) print $2}' "$files")"
    return $ret_code
}

check_prereqs() {
    for cmd in ldd readelf awk file sort uniq grep sed; do
        if ! command -v $cmd >/dev/null 2>&1; then
            error "error: $cmd required but not found"
            exit 1
        fi
    done
}

package_dir=$1
if [[ -z "$package_dir" ]]; then
    usage
    error "error: package directory required"
    exit 1
fi

check_prereqs
check_files "$package_dir"
exit $?
