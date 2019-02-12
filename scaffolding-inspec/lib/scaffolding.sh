#
# A scaffolding for InSpec
#

scaffolding_load() {
  : "${scaffold_inspec:=chef/inspec}"

  pkg_deps=(
    "${pkg_deps[@]}"
    "$scaffold_inspec"
    "core/cacerts"
  )
  pkg_build_deps=(
    "${pkg_build_deps[@]}"
  )

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
  chmod 0750 "$pkg_prefix/hooks"

  # Run hook
  cat << EOF >> "$pkg_prefix/hooks/run"
#/bin/sh

export SSL_CERT_FILE="{{pkgPathFor "core/cacerts"}}/ssl/cert.pem"

# InSpec will try to create a .cache directory in the user's home directory
# so this needs to be someplace writeable by the user
export HOME={{pkg.svc_var_path}}

exec 2>&1

while true; do
{{pkgPathFor "chef/inspec"}}/bin/inspec exec {{#each cfg.profiles as |profile| ~}} {{profile}} {{/each ~}} --json-config {{pkg.svc_config_path}}/inspec.json --target-id {{sys.member_id}}
sleep {{cfg.interval}}

done
EOF
  chmod 0750 "$pkg_prefix/hooks/run"
}

do_default_build() {
  return 0
}

do_default_install() {
  mkdir -p "$pkg_prefix/config"
  chmod 0750 "$pkg_prefix/config"
  cat << EOF >> "$pkg_prefix/config/inspec.json"
{
  "reporter": {
      "automate" : {
          "stdout" : "{{cfg.reporter.stdout}}",
          "url" : "{{cfg.reporter.url}}",
          "token" : "{{cfg.reporter.token}}",
          "node_name" : "{{ sys.hostname }}",
          "verify_ssl" : false,
          "node_uuid" : "{{sys.member_id}}"
      }
  },
  "compliance": {
      "server" : "{{cfg.compliance.server}}",
      "token" : "{{cfg.compliance.token}}",
      "user" : "{{cfg.compliance.user}}",
      "insecure" : true,
      "ent" : "{{cfg.compliance.enterprise}}"
  }
}
EOF
  chmod 0640 "$pkg_prefix/config/inspec.json"

  cat << EOF >> "$pkg_prefix/default.toml"
# These settings are examples only and are intended to be overriden with
# the correct values to connect to your Chef Automate.
interval = 1800
profiles=["compliance://admin@example.com/cis-sles12-level1", "compliance://admin@example.com/linux-baseline"]

# https://docs.chef.io/data_collection.html
[reporter]
stdout = true
url = "https://automate.example.com/data-collector/v0/"
token = "_O2S2TbCVrA_IGR7SozoEXAMPLE="
verify_ssl = true

[compliance]
server = "automate.example.com"
token = "_O2S2TbCVrA_IGR7SozoEXAMPLE="
user = "admin@example.com"
insecure = false
ent = "default"
EOF
  chmod 0640 "$pkg_prefix/default.toml"
}

do_default_strip() {
  return 0
}
