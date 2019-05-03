pkg_name=freetype_setenv
pkg_origin='test'
pkg_description='A plan to test the most basic configuration of core/freetype'
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_deps=(
  core/zlib
  core/libpng
  "${HAB_ORIGIN}/freetype"
)
pkg_build_deps=( core/diffutils core/bats )
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pconfig)

do_build() { return 0; }

do_install() {
  mkdir -p "${pkg_prefix}/bin"
	cat > "${pkg_prefix}/bin/setenv.sh" <<-EOL
		#!/bin/bash
		echo "export PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
		EOL
  chmod 755 "${pkg_prefix}/bin/setenv.sh"
  return 0
}

do_after() {
  run_all_tests ${pkg_deps[@]}
}

run_all_tests() {
  local array_of_pkg_deps=("${@}")

  build_line "~~~~~~~~~~~~~~~~~ Start Habitat Build Tests ~~~~~~~~~~~~~~~~~"

  # initialize $_tests_have_failed
  local _tests_have_failed="false"

  # run all bats tests for each $_dependency in the $array_of_pkg_deps
  for _dependency in "${array_of_pkg_deps[@]}";
  do
      local _dependency_path=''; _dependency_path="$(pkg_path_for ${_dependency})"

      # only do something with a $_dependency that contains bats tests
      if [[ -e "${_dependency_path}/test/bats" ]]; then
        build_line "running tests for ${_dependency}"

        # don't exit on individual failures but set $_tests_have_failed instead
        local _array_of_bats_files="$( find "${_dependency_path}/test/bats" -type f -name "*.bats" -print )"
        for _bats_file in ${_array_of_bats_files[@]}; do
          build_line "${_bats_file}"
          bats "${_bats_file}" || _tests_have_failed="true"
        done

      else
        build_line "no tests defined for ${_dependency}"
      fi
  done

  build_line "~~~~~~~~~~~~~~~~~ Finish Habitat Build Tests ~~~~~~~~~~~~~~~~~"
  # fail the build if any of $_tests_have_failed
  if [[ "${_tests_have_failed}" == "true" ]]; then
    warn "check the build for failing tests"
    exit 1
  fi
}
