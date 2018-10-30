#
# A scaffolding for Chef Policyfile packages
#

if [ -z "${scaffold_policy_name+x}" ]; then
  echo "You must set \$scaffold_policy_name to a valid policy name. For example:"
  echo
  echo "\$scaffold_policy_name=base"
  echo
  echo "Will build a base.rb policyfile"
  exit 1
fi

scaffolding_load() {
  parent_deps="${pkg_deps[*]}"
  pkg_deps=("chef/chef-client" "core/cacerts")
  for i in $parent_deps; do
    pkg_deps+=($i)
  done
  parent_build_deps="${pkg_build_deps[*]}"
  pkg_build_deps=("chef/chef-dk" "core/git")
  for i in $parent_build_deps; do
    pkg_build_deps+=($i)
  done
  pkg_svc_user="root"
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

do_default_build_service() {
  ## Create hooks
  mkdir -p "$pkg_prefix/hooks"
  chown 0644 "$pkg_prefix/hooks"

  # Run hook
  cat << EOF >> "$pkg_prefix/hooks/run"
#!/bin/sh

export SSL_CERT_FILE="{{pkgPathFor "core/cacerts"}}/ssl/cert.pem"

cd {{pkg.path}}

exec 2>&1
chef-client -z -l {{cfg.log_level}} -c $pkg_svc_config_path/client-config.rb --once
exec chef-client -z -i {{cfg.interval}} -s {{cfg.splay}} -l {{cfg.log_level}} -c $pkg_svc_config_path/client-config.rb
EOF
  chown 0755 "$pkg_prefix/hooks/run"
}

do_default_build() {
  if [ -d "$PLAN_CONTEXT/../policyfiles" ]; then
    _policyfile_path="$PLAN_CONTEXT/../policyfiles"
  else
    if [ -d "$PLAN_CONTEXT/../../policyfiles" ]; then
      _policyfile_path="$PLAN_CONTEXT/../../policyfiles"
    else
      if [ -d "$PLAN_CONTEXT/../../../policyfiles" ]; then
        _policyfile_path="$PLAN_CONTEXT/../../../policyfiles"
      else
        echo "Cannot detect a policyfiles directory!"
        exit 1
      fi
    fi
  fi
  rm -f "$_policyfile_path"/*.lock.json
  policyfile="$_policyfile_path/$scaffold_policy_name.rb"
  for x in $(grep include_policy "$policyfile" | awk -F "," '{print $1}' | awk -F '"' '{print $2}' | tr -d " "); do
    chef install "$_policyfile_path/$x.rb"
  done
  chef install "$policyfile"
}

do_default_install() {
  chef export "$_policyfile_path/$scaffold_policy_name.lock.json" "$pkg_prefix"

  mkdir -p "$pkg_prefix/config"
  chown 0755 "$pkg_prefix/config"
  cat << EOF >> "$pkg_prefix/.chef/config.rb"
cache_path "$pkg_svc_data_path/cache"
node_path "$pkg_svc_data_path/nodes"
role_path "$pkg_svc_data_path/roles"

ssl_verify_mode {{cfg.ssl_verify_mode}}
chef_zero.enabled true
EOF

  cp "$pkg_prefix/.chef/config.rb" "$pkg_prefix/config/bootstrap-config.rb"
  cat << EOF >> "$pkg_prefix/config/bootstrap-config.rb"
ENV['PATH'] = "/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:#{ENV['PATH']}"
EOF

  cp "$pkg_prefix/.chef/config.rb" "$pkg_prefix/config/client-config.rb"
  cat << EOF >> "$pkg_prefix/config/client-config.rb"
ENV['PATH'] = "{{cfg.env_path_prefix}}:#{ENV['PATH']}"

{{#if cfg.data_collector.enable ~}}
data_collector.token "{{cfg.data_collector.token}}"
data_collector.server_url "{{cfg.data_collector.server_url}}"
{{/if ~}}
EOF
  chown 0644 "$pkg_prefix/config/client-config.rb"

  ## Create config
  cat << EOF >> "$pkg_prefix/default.toml"
interval = 1800
splay = 180
log_level = "warn"
env_path_prefix = "/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin"
ssl_verify_mode = ":verify_peer"

[data_collector]
enable = false
token = "set_to_your_token"
server_url = "set_to_your_url"
EOF
  chown 0644 "$pkg_prefix/default.toml"
}

do_default_strip() {
  return 0
}
