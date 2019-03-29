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

habitat::_list_results() {
  find ${PLAN_ROOT} -type d -name "results" -print | xargs ls -1
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Private Functions END
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

habitat::build_haproxy() {
    habitat::_build_plan_at ${PLAN_ROOT}
}

habitat::load_haproxy() {
  # install the locally built core/haproxy
  source ${PLAN_ROOT}/results/last_build.env
  hab pkg install ${PLAN_ROOT}/results/$pkg_artifact

  # build the test plan that includes core/haproxy 
  habitat::_build_plan_at ${PLAN_ROOT}/test/haproxy/
  habitat::_build_plan_at ${PLAN_ROOT}/test/webapp/
  
  # wait until the webapp plan loads
  source ${PLAN_ROOT}/test/webapp/results/last_build.env
  hab svc unload $pkg_origin/$pkg_name
  hab svc load $pkg_origin/$pkg_name
  habitat::_wait_listen tcp 9090 30

  # wait until the load balancer loads
  source ${PLAN_ROOT}/test/haproxy/results/last_build.env
  hab svc unload $pkg_origin/$pkg_name
  hab svc load $pkg_origin/$pkg_name --bind=backend:webapp.default
  habitat::_wait_listen tcp 80 30
}

habitat::test_haproxy() {
  habitat::_install_inspec

   hab pkg exec chef/inspec inspec exec ${PLAN_ROOT}/test
}