#!/usr/bin/env bash
#
# Usage: bin/check-uploaded-version.sh [PACKAGE...]
#
# Finds packages where the uploaded version of the package does not
# match what is committed to the repository.
#
set -euo pipefail

all_plans() {
    for i in */plan.sh; do
        dirname "$i"
    done
}

clean_args() {
    for arg in "$@"; do
        arg=${arg%/}
        if [[ "$arg" = */* ]]; then
            dirname "$arg"
        else
            echo "$arg"
        fi
    done
}

get_plan_data() {
    local plan_directory=$1
    (
        unset pkg_name pkg_version
        set +u
        set +e
        export PLAN_CONTEXT="$plan_directory"
        cd "$PLAN_CONTEXT"
        # shellcheck disable=SC1091
        . "plan.sh"
        echo "$pkg_name ${pkg_version:-unknown}"
    )
}

get_latest_stable() {
    local pkg_name=$1
    local url="https://bldr.habitat.sh/v1/depot/channels/core/stable/pkgs/$pkg_name/latest"
    curl "$url" 2>/dev/null | jq -r .ident.version
}

if [[ "${BASH_VERSINFO[0]}" -lt 4 ]]; then
    echo "error: Bash 4 or greater is required. Found ${BASH_VERSINFO[0]}."
    exit 1
fi

for cmd in curl jq dirname; do
    if ! command -v $cmd >/dev/null 2>&1; then
        echo "error: $cmd required but not found"
        exit 1
    fi
done

declare -a plans_to_check
if [[ "$#" -ne 0 ]]; then
    mapfile -t plans_to_check < <(clean_args "$@")
else
    mapfile -t plans_to_check < <(all_plans)
fi

ret=0
for plan in "${plans_to_check[@]}"; do
    uploaded_version="unknown"
    read -r pkg_name pkg_version < <(get_plan_data "$plan")
    if [[ "$pkg_version" = "unknown" ]]; then
        echo "$pkg_name: unknown local version"
        ret=1
    else
        if uploaded_version=$(get_latest_stable "$pkg_name"); then
            if [[ "$uploaded_version" != "$pkg_version" ]]; then
                echo "$pkg_name: mismatch (uploaded: $uploaded_version, source: $pkg_version)"
                ret=1
            fi
        else
            echo "$pkg_name: failed to query stable version"
            ret=1
        fi

    fi
done
exit "$ret"
