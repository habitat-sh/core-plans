pkg_name=dd-agent
pkg_origin=core
pkg_version="5.32.8"
pkg_supervisor_version="3.3.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Datadog Agent"
pkg_license=("BSD-3-Clause")
pkg_upstream_url="https://github.com/datadog/dd-agent"
pkg_build_deps=(
  core/curl
  core/gcc
  core/git
  core/make
  core/openssl
  core/ruby
  core/python2
  core/sed
  core/tar
)
pkg_deps=(
  core/python2
  core/sysstat
  core/busybox-static
)
pkg_dirname="datadog-agent"
pkg_bin_dirs=(
  dd-agent/bin
  dd-agent/venv/bin
)
pkg_lib_dirs=(
  dd-agent/venv/lib
)
pkg_svc_run="agent"
pkg_svc_user="root" # needed for supervisord

do_begin() {
  export DD_HOME="${pkg_prefix}/dd-agent"
  export DD_START_AGENT=0
  export DD_API_KEY="{{cfg.dd_api_key}}"
}

do_build() {
  mkdir -p "${DD_HOME}"
  env PATH="$(pkg_path_for core/tar)/bin:${PATH}" sh -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/setup_agent.sh)"
  fix_interpreter "${DD_HOME}/bin/agent" core/busybox-static bin/env
  rm -fr "${DD_HOME}/logs"
  ln -s "${pkg_svc_var_path}" "${DD_HOME}/logs"
  mkdir -p "${pkg_prefix}/config"
  mv "${DD_HOME}/agent/datadog.conf" "${pkg_prefix}/config"
  ln -s "${pkg_svc_config_path}/datadog.conf" "${DD_HOME}/agent/datadog.conf"
}

do_install() {
  return 0
}

do_strip() {
  return 0
}
