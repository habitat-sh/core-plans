#!/bin/bash
#
# Usage: bin/check-bins.sh PACKAGE_INSTALL_PATH
#
# Finds any executable or library files that are missing essential
# dependencies.
#
set -euo pipefail

_header_printed=""

error() {
    echo "$@" >&2
}

usage() {
    error "Usage: $0 PACKAGE_INSTALL_PATH"
}

check_file() {
    local file="$1"
    missing_libs=$(ldd "$file" | awk '/not found/ {print $1}')
    if [[ -n "$missing_libs" ]]; then
        if [[ -z "${_header_printed}" ]]; then
            error "MISSING DEPENDENCIES"
            _header_printed="true"
        fi
        error "$file:"
        error "      $missing_libs"
        return 1
    fi
}

should_check() {
    case "$(file -bi "$1")" in
        *application/x-*executable*) return 0;;
        *application/x-*sharedlib*) return 0;;
        *application/x-*archive*) return 0;;
        *) return 1;;
    esac
}

check_files() {
    local dir="$1"
    local files="$dir/FILES"

    if [[ ! -f "$files" ]]; then
        error "could not find FILES manifest in $dir"
        return 1
    fi

    local ret_code=0
    while read -r f; do
        if should_check "$f"; then
            if ! check_file "$f"; then
                ret_code=1
            fi
        fi
    done <<< "$(awk '{if (NR > 5) print $2}' "$files")"
    return $ret_code
}

check_prereqs() {
    for cmd in ldd awk file; do
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
