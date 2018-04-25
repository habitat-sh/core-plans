source "${PLAN_CONTEXT}/../readline/plan.sh"

pkg_name="readline6"
pkg_origin="core"
_base_version=6.3
pkg_version=${_base_version}.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
The GNU Readline library provides a set of functions for use by applications \
that allow users to edit command lines as they are typed in.\
"
pkg_upstream_url="http://tiswww.case.edu/php/chet/readline/rltop.html"
pkg_license=('GPL-3.0')
pkg_source="${_url_base}/${_distname}-${_base_version}.tar.gz"
pkg_shasum="56ba6071b9462f980c5a72ab0023893b65ba6debb4eeb475d7a563dc65cafd43"
pkg_dirname="${_distname}-${_base_version}"

do_begin() {
  source "${PLAN_CONTEXT}/readline-patches.sh"
}
