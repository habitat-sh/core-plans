{{#unless cfg.backend.type~}}
backend "inmem" {}
{{/unless ~}}
{{#if cfg.backend.type.inmem~}}
backend "inmem" {}
{{/if ~}}
{{#if cfg.backend.type.filesystem~}}
backend "file" {
  path = "{{svc_data_path}}{{cfg.backend.storage_file_path}}"
}
{{/if ~}}
{{#if cfg.backend.type.consul~}}
backend "consul" {
  address = "{{cfg.backend.address}}"
  path = "{{cfg.backend.path}}"
}
{{/if ~}}
{{#if cfg.backend.type.dynamodb~}}
backend "dynamodb" {
  endpoint = "{{cfg.backend.endpoint}}"
  ha_enabled = "{{cfg.backend.ha_enabled}}"
  max_parallel = "{{cfg.backend.max_parallel}}"
  region = "{{cfg.backend.region}}"
  read_capacity = {{cfg.backend.read_capacity}}
  table = "{{cfg.backend.table}}"
  write_capacity = {{cfg.backend.write_capacity}}
  {{#if cfg.backend.access_key~}}
  access_key = "{{cfg.backend.access_key}}"
  {{/if ~}}
  {{#if cfg.backend.secret_key~}}
  secret_key = "{{cfg.backend.secret_key}}"
  {{/if ~}}
  {{#if cfg.backend.session_token~}}
  session_token = "{{cfg.backend.session_token}}"
  {{/if ~}}
}
{{/if ~}}

ui = {{cfg.app.ui}}

listener "{{cfg.listener.type}}" {
  address = "{{cfg.listener.location}}:{{cfg.listener.port}}"
  tls_disable = {{cfg.listener.tls_disable}}
  {{#if cfg.listener.tls_disable~}}
  tls_cert_file = "{{pkg.svc_files_path}}/{{cfg.listener.tls_cert_file}}"
  tls_key_file = "{{pkg.svc_files_path}}/{{cfg.listener.tls_key_file}}"
  {{/if ~}}
}
