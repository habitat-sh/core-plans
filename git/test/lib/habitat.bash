#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Private Functions START
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

habitat::_install_netcat() {
  hab pkg path core/busybox-static > /dev/null
  if [[ ${?} != 0 ]]; then
    hab pkg install core/busybox-static
  fi
}

habitat::_install_inspec() {
  hab pkg path chef/inspec > /dev/null
  if [[ ${?} != 0 ]]; then
    # install chef/inspec and dependency core/busybox
    hab pkg install -b core/busybox
    hab pkg install chef/inspec
  fi
}

habitat::_test_listen() {
  habitat::_install_netcat

  local proto="-z"
  if [ "${1}" == "udp" ]; then
    proto="-u"
  fi
  local wait=${3:-3}
  hab pkg exec core/busybox-static nc "${proto}" -w"${wait}" 127.0.0.1 "${2}"
  return $?
}

habitat::_wait_listen() {
  habitat::_install_netcat

  local proto="-z"
  if [ "${1}" == "udp" ]; then
    proto="-u"
  fi
  local wait=${3:-1}
  while ! hab pkg exec core/busybox-static nc "${proto}" -w"${wait}" 127.0.0.1 "${2}"; do
    sleep 1
  done
}

habitat::_build_plan_at() {
  local _plan_directory_path="$1"; shift

  # use subshell to isolate the cd
  (
    cd ${_plan_directory_path}
    build .
  )
}

habitat::_create_yaml_file_for() {
  local _plan_directory_path="$1"; shift

  # create a yml version for inspec usage ignoring the first blank line in the *.env
  if [[ -f "${_plan_directory_path}/results/last_build.env" ]]; then
    sed -n "2,$ p" "${_plan_directory_path}/results/last_build.env" | sed "s/=/: '/g" | sed "s/$/'/g" > "${_plan_directory_path}/results/last_build.yml"
  fi
}


habitat::_list_results() {
  find ${PLAN_ROOT} -type d -name "results" -print | xargs ls -1
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Private Functions END
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

habitat::build_git() {
    habitat::_build_plan_at ${PLAN_ROOT}
}

habitat::load_git() {
  # install the locally built core/git
  source ${PLAN_ROOT}/results/last_build.env
  hab pkg install ${PLAN_ROOT}/results/$pkg_artifact
}

habitat::test_git() {
  habitat::_install_inspec
  habitat::_create_yaml_file_for ${PLAN_ROOT}

  hab pkg exec chef/inspec inspec exec ${PLAN_ROOT}/test --attrs ${PLAN_ROOT}/results/last_build.yml
}