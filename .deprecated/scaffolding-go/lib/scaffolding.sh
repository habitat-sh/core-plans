# The default_begin phase is executed prior to loading the scaffolding. As such
# we have a scaffolding specific callback to allow us to run anything we need
# to execute before download and build. This callback executes immediately
# after the scaffolding is loaded.
scaffolding_load() {
  local lib_dir
  lib_dir="$(pkg_path_for "$pkg_scaffolding")/lib"

  # When the user enables go module support,
  # we don't need to setup the GOPATH
  export GO111MODULE=${scaffolding_go_module:-"auto"}

  if [[ "$GO111MODULE" == "on" ]]; then
    build_line "Using Go Module Scaffolding"
    source "${lib_dir}/go_module.sh"
  else
    build_line "Using GOPATH Mode Scaffolding"
    source "${lib_dir}/gopath_mode.sh"
  fi
}
