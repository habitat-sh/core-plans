#!/usr/bin/env bash
#
# Usage: bin/check-verions.sh
#
# Checks the verison of all packages against the
# https://release-monitoring.org API
#
set -euo pipefail

BASE_PLANS_FILE="./base-plans.txt"
RELEASE_MONITORING_ID_FILE="./release_monitoring_ids"
DEBUG=${DEBUG:-0}

declare -A release_monitoring_ids
declare -a plans_to_check

debug() {
    if [[ "$DEBUG" -ge 1 ]]; then
        echo "DEBUG: $*" >&2
    fi
}

error() {
    echo "$@" >&2
}

get_latest_version() {
    local project_id=$1
    local curl_logging_args
    if [[ "$DEBUG" -ge 2 ]]; then
       curl_logging_args=("-vv")
    else
        curl_logging_args=("--stderr" "/dev/null")
    fi

    if output=$(curl "${curl_logging_args[@]}" --retry 2 "https://release-monitoring.org/api/project/$project_id"); then
       jq -r .version <<<"$output"
    else
        error "release-monitoring.org returned an error."
        error "STDOUT:"
        error "$output"
        error ""
        return 1
    fi
}

load_metadata() {
    while read -r plan_name package_id; do
        release_monitoring_ids[$plan_name]=$package_id
    done <"$RELEASE_MONITORING_ID_FILE"
}

is_base_plan() {
    grep "^core-plans/$1\$" "$BASE_PLANS_FILE" >/dev/null
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

STATUS_OK="ok"
STATUS_OLD="out-of-date"
STATUS_UNKNOWN="unknown"

table_print() {
    local plan=$1
    local current=$2
    local latest=$3
    local status=$4
    local note=${5:-}

    case "$status" in
        $STATUS_OLD)
            color_code="\e[31m"
            ;;
        $STATUS_OK)
            color_code="\e[32m"
            ;;
        $STATUS_UNKNOWN)
            color_code="\e[33m"
            ;;
        *)
            color_code=""
            ;;
    esac
    printf "$color_code%-30s %-16.16s %-16.16s %-12s %s\e[0m\n" "$plan" "$current" "$latest" "$status" "$note"
}

all_plans() {
    for i in */plan.sh; do
        dirname "$i"
    done
}

check_prereqs() {
    for cmd in curl jq; do
        if ! command -v $cmd >/dev/null 2>&1; then
            error "error: $cmd required but not found"
            exit 1
        fi
    done
}

clean_args() {
    for arg in "$@"; do
        if [[ "$arg" = */* ]]; then
            dirname "$arg"
        else
            echo "$arg"
        fi
    done
}

check_prereqs
load_metadata

if [[ "$#" -ne 0 ]]; then
    mapfile -t plans_to_check < <(clean_args "$@")
else
    mapfile -t plans_to_check < <(all_plans)
fi

outdated=0
up_to_date=0
unknown=0
bp_outdated=0
bp_up_to_date=0
bp_unknown=0
ret=0

debug "Starting with ${plans_to_check[*]}"
table_print "Plan" "Plan Version" "Latest Version" "Status" "Notes"
for plan in "${plans_to_check[@]}"; do
    latest_version="unknown"
    read -r pkg_name pkg_version < <(get_plan_data "$plan")
    pkg_release_monitoring_id=${release_monitoring_ids[$pkg_name]:-unknown}

    if [[ "$pkg_release_monitoring_id" = "unknown" ]]; then
        if is_base_plan "$pkg_name"; then
            table_print "$pkg_name" "$pkg_version" "unknown" "$STATUS_UNKNOWN" "(base plan)"
            bp_unknown=$((bp_unknown + 1))
        else
            table_print "$pkg_name" "$pkg_version" "unknown" "$STATUS_UNKNOWN"
            unknown=$((unknown + 1))
        fi
    else
        latest_version=$(get_latest_version "$pkg_release_monitoring_id")
        if [[ "$latest_version" != "$pkg_version" ]]; then
            if is_base_plan "$pkg_name"; then
                table_print "$pkg_name" "$pkg_version" "$latest_version" "$STATUS_OLD" "(base plan)"
                bp_outdated=$((bp_outdated + 1))
            else
                ret="1"
                table_print "$pkg_name" "$pkg_version" "$latest_version" "$STATUS_OLD"
                outdated=$((outdated + 1))
            fi
        else
            if is_base_plan "$pkg_name"; then
                table_print "$pkg_name" "$pkg_version" "$latest_version" "$STATUS_OK" "(base plan)"
                bp_up_to_date=$((bp_up_to_date + 1))
            else
                table_print "$pkg_name" "$pkg_version" "$latest_version" "$STATUS_OK"
                up_to_date=$((up_to_date + 1))
            fi
        fi
    fi
done

echo "==== Summary ===="
echo "----------"
echo "Base Plans"
echo "----------"
echo "up-to-date: $bp_up_to_date"
echo "  outdated: $bp_outdated"
echo "   unknown: $bp_unknown"
echo "     total: $((bp_up_to_date + bp_outdated + bp_unknown))"
echo ""
echo "----------"
echo "Other Plans"
echo "-----------"
echo "up-to-date: $up_to_date"
echo "  outdated: $outdated"
echo "   unknown: $unknown"
echo "     total: $((up_to_date + outdated + unknown))"
echo "================="
exit "$ret"
