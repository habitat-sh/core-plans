# Set node name
# Specifies the name of the local node. This value is used to 
# identify individual nodes in a given datacenter and must be 
# unique per-datacenter. We set this to the hab gossip member ID
# Node ip address is "{{sys.ip}}"
    name = "{{sys.member_id}}"

# Set bind address
    bind_addr = "{{cfg.bind_addr}}"

# Set log verbosity
    log_level = "{{cfg.log_level}}"

# Setup data dir
    data_dir = "{{pkg.svc_data_path}}"

{{#if cfg.nomad.datacenter}}
    datacenter = "{{cfg.nomad.datacenter}}"
{{/if ~}}

# Specifies the region the Nomad agent is a member of. 
# Typically maps to a geographic location
    region = "{{cfg.nomad.region}}"

# Extra options
# Any options not provided by default can be added to
# the options array and will be rendered here
{{#each cfg.extras}}
    {{@key}} = {{this}}
{{~/each ~}}

{{#if cfg.nomad.agent}}
# Enable the client
client {
    enabled = true    
    servers = [{{#eachAlive bind.servers.members as |member|}}"{{member.sys.ip}}",{{/eachAlive}}]
    {{#if client.options}}
    options {
        {{#each cfg.client.options}}
        "{{@key}}" = "{{this}}"
        {{~/each}}
    }
    {{/if ~}}
}
{{/if ~}}
{{#if cfg.nomad.server}}
# Enable the server
server {
    enabled = true
    # Nodes to expect before bootstrapping cluster
    bootstrap_expect = {{cfg.nomad.bootstrap_expect}}
    retry_join = [{{#eachAlive bind.servers.members as |member|}}"{{member.sys.ip}}"{{#unless @last}}, {{/unless}} {{/eachAlive}}]
    retry_interval = "30s"
    retry_max = 0 
}
{{/if ~}}

{{#with cfg.ports}}
ports {
    http = {{http}}
    rpc  = {{rpc}}
    serf = {{serf}}
}
{{/with}}