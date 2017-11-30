source "${PLAN_CONTEXT}/../base/plan.sh"

# We want to change the `pkg_source` link to the correct version
_base_version=6.3
pkg_version=${_base_version}.8
pkg_source="${_url_base}/${pkg_name}-${_base_version}.tar.gz"
pkg_dirname="${pkg_name}-${_base_version}"
pkg_shasum=56ba6071b9462f980c5a72ab0023893b65ba6debb4eeb475d7a563dc65cafd43

do_begin() {
  local -r pkg_name="readline"
  source "${PLAN_CONTEXT}/readline-patches.sh"
}

# And the `pkg_name` only after the link was set up
pkg_name=readline6
