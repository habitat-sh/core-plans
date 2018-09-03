#
# A scaffolding for Chef Policyfile packages
#

if [ -z "${scaffold_policy_name+x}" ]; then
  warn "You must set \$scaffold_policy_name to a valid policy name. For example:"
  warn ""
  warn "\$scaffold_policy_name=base"
  warn ""
  warn "Will build policy either from base.lock.json or base.rb"
  exit_with "scaffold_policy_name is unset. Exiting" 1
fi

scaffolding_load() {
  : "${scaffold_policy_group:=local}"
  : "${scaffold_chef_client:=chef/chef-client}"
  : "${scaffold_chef_dk:=chef/chef-dk}"

  pkg_deps=(
    ${pkg_deps[@]}
    $scaffold_chef_client
    core/cacerts
    core/busybox-static
  )

  pkg_build_deps=(
    ${pkg_build_deps[@]}
    $scaffold_chef_dk
    core/git
  )

  pkg_svc_user=root
  pkg_svc_group=root
  pkg_svc_run="set_just_so_you_will_render"
}

do_default_download() {
  return 0
}

do_default_verify() {
  return 0
}

do_default_unpack() {
  return 0
}

do_default_build_config() {
  scaffolding_build_default_toml

  scaffolding_build_config
  scaffolding_build_config_bootstrap
  scaffolding_build_config_client
  scaffolding_build_config_node

  scaffolding_build_hooks
  scaffolding_build_hook_run
}

do_default_build_service() {
  return 0
}

do_default_build() {
  scaffolding_detect_policy
  scaffolding_build_policy
}

do_default_install() {
  scaffolding_install_policy
}

do_default_strip() {
  return 0
}

scaffolding_detect_policy() {
  local search_path="$PLAN_CONTEXT"

  while [ "$search_path" != "/" ]; do
    build_line "Looking for policy files in $search_path/policyfiles"
    test -d "$search_path/policyfiles" && break
    search_path=$(dirname "$search_path")
  done

  policyfiles="$search_path/policyfiles"
  policyfile_rb=$policyfiles/$scaffold_policy_name.rb
  policyfile_lock=$policyfiles/$scaffold_policy_name.lock.json

  if [ ! -d "$policyfiles" ]; then
    exit_with "Unable to find policyfiles directory in all parent folders"
  fi

  if [ -f "$policyfile_lock" ]; then
    build_line "Detected $policyfile_lock"
  elif [ -f "$policyfile_rb" ]; then
    warn "Detected only source $policyfile_rb"
  else
    exit_with "Neither $policyfile_lock nor $policyfile_rb was found"
  fi
}

scaffolding_build_policy() {
  if [ -f "$policyfile_lock" ]; then
    build_line "Using lock from: $policyfile_lock"
    chef install "$policyfile_lock"
  elif [ -f "$policyfile_rb" ]; then
    warn "Using source from: $policyfile_rb"
    chef install "$policyfile_rb"
  else
    exit_with "Policy: $scaffold_policy_name is not found"
  fi
}

scaffolding_build_default_toml() {
  cat << EOF > "$pkg_prefix/default.toml"
env_path_prefix = "/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin"

interval = 1800
splay = 180
log_level = "warn"

named_run_list = ""

ssl_verify_mode = ":verify_none"

[data_collector]
enable = false
token = "set_to_your_token"
server_url = "set_to_your_url"

# Chefs' Node attributes
[node]
policy_name = "$scaffold_policy_name"
policy_group = "$scaffold_policy_group"
EOF

  chmod 0640 "$pkg_prefix/default.toml"
}

scaffolding_build_config() {
  if [ ! -d "$pkg_prefix/config" ]; then
    mkdir -p "$pkg_prefix/config"
    chmod 0750 "$pkg_prefix/config"
  fi
}

# This config can be used as is without habitat supervisor running
scaffolding_build_config_bootstrap() {
  cat << EOF > "$pkg_prefix/config/bootstrap-config.rb"
policy_name '$scaffold_policy_name'
policy_group '$scaffold_policy_group'

use_policyfile true
policy_document_native_api true

cache_path "$pkg_svc_data_path/cache"
node_path "$pkg_svc_data_path/nodes"
role_path "$pkg_svc_data_path/roles"

ssl_verify_mode :verify_none

ENV['PATH'] = "/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:#{ENV['PATH']}"
ENV['GEM_PATH'] = "$pkg_prefix:#{ENV['GEM_PATH']}"
EOF
  chmod 0640 "$pkg_prefix/config/bootstrap-config.rb"
}

scaffolding_build_config_client() {
  cat << EOF > "$pkg_prefix/config/client-config.rb"
policy_name '$scaffold_policy_name'
policy_group '$scaffold_policy_group'

{{#if cfg.named_run_list ~}}
named_run_list "{{cfg.named_run_list}}"
{{/if ~}}

use_policyfile true
policy_document_native_api true

cache_path "$pkg_svc_data_path/cache"
node_path "$pkg_svc_data_path/nodes"
role_path "$pkg_svc_data_path/roles"

json_attribs "{{pkg.svc_config_path}}/node.json"
ssl_verify_mode {{cfg.ssl_verify_mode}}

{{#if cfg.data_collector.enable ~}}
data_collector.token "{{cfg.data_collector.token}}"
data_collector.server_url "{{cfg.data_collector.server_url}}"
{{/if ~}}

ENV['PATH'] = "{{cfg.env_path_prefix}}:#{ENV['PATH']}"
ENV['GEM_PATH'] = "$pkg_prefix:#{ENV['GEM_PATH']}"
EOF
  chmod 0640 "$pkg_prefix/config/client-config.rb"
}

scaffolding_build_config_node() {
  cat <<EOF > "$pkg_prefix/config/node.json"
{{toJson cfg.node}}
EOF

  chmod 0750 "$pkg_prefix/config/node.json"
}

scaffolding_build_hooks() {
  if [ ! -d "$pkg_prefix/hooks" ]; then
    mkdir -p "$pkg_prefix/hooks"
    chmod 0750 "$pkg_prefix/hooks"
  fi
}

scaffolding_build_hook_run() {
  cat << EOF > "$pkg_prefix/hooks/run"
#!{{pkgPathFor "core/busybox-static"}}/bin/sh

export SSL_CERT_FILE="{{pkgPathFor "core/cacerts"}}/ssl/cert.pem"

cd {{pkg.path}}

exec 2>&1

while true; do
SPLAY_DURATION=\$({{pkgPathFor "core/busybox-static"}}/bin/shuf -i 0-{{cfg.splay}} -n 1)
sleep \$SPLAY_DURATION
chef-client -z -l {{cfg.log_level}} -c {{pkg.svc_config_path}}/client-config.rb --once --no-fork --run-lock-timeout {{cfg.interval}}
sleep {{cfg.interval}}
done
EOF

  chmod 0750 "$pkg_prefix/hooks/run"
}

scaffolding_install_policy() {
  if [ -f "$policyfile_lock" ]; then
    chef export "$policyfile_lock" "$pkg_prefix"
  else
    exit_with "$policyfile_lock was not found"
  fi
}
