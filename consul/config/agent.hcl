{{ #if cfg.agent.bind_addr }}
bind_addr =  "{{cfg.agent.bind_addr}}"
{{ else }}
bind_addr =  "{{sys.ip}}"
{{ /if }}

{{ #if cfg.agent.data_dir }}
data_dir = "{{cfg.agent.data_dir}}"
{{ else }}
data_dir = "{{pkg.svc_data_path}}"
{{ /if }}

{{ #if cfg.agent.client_addr }}
client_addr = "{{cfg.agent.client_addr}}"
{{ else }}
client_addr = "{{sys.ip}}"
{{ /if }}

{{ #if cfg.encryption.gossip }}
encrypt                 = "{{cfg.encryption.gossip_key}}"
encrypt_verify_incoming = {{cfg.encryption.verify_gossip_incoming}}
encrypt_verify_outgoing = {{cfg.encryption.verify_gossip_outgoint}}
{{ /if }}

{{ #if cfg.encryption.tls }}
verify_incoming        = {{cfg.encryption.verify_incoming}}
verify_outgoing        = {{cfg.encryption.verify_outgoing}}
verify_server_hostname = {{cfg.encryption.verify_server_hostname}}
ca_file                = "{{cfg.encryption.ca_file}}"
cert_file              = "{{cfg.encryption.cert_file}}"
key_file               = "{{cfg.encryption.key_file}}"
{{ /if }}

retry_join       = [
{{~#eachAlive svc.members as |member| ~}}
  "{{member.sys.ip}}"
{{~/eachAlive}}
]
bootstrap_expect = {{cfg.agent.bootstrap_expect}}
datacenter       = "{{cfg.agent.datacenter}}"
log_level        = "{{cfg.agent.log_level}}"
performance      = {
  raft_multiplier = 1
}
server           = {{cfg.agent.mode}}
ui               = {{cfg.agent.ui}}

ports            = {
  dns      = {{cfg.ports.dns}}
  http     = {{cfg.ports.http}}
  https    = {{cfg.ports.https}}
  serf_lan = {{cfg.ports.serf_lan}}
  serf_wan = {{cfg.ports.serf_wan}}
  server   = {{cfg.ports.server}}
}
