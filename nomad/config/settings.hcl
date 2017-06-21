# Set bind address
bind_addr = "{{cfg.bind_addr}}"

# Set log verbosity
log_level = "{{cfg.log_level}}"

# Setup data dir
data_dir = "{{pkg.svc_data_path}}"

{{#if svc.me.follower}}
   {{#with svc.leader as |leader|}}
# Enable the client
client {
    enabled = true    
    servers = ["{{leader.sys.ip}}:{{leader.cfg.ports.serf}}"]
    }
   {{/with}}
   {{else}}
# Enable the server
server {
    enabled = true
    
    # Nodes to expect before bootstrapping cluster
    bootstrap_expect = {{cfg.bootstrap_expect}} 
}
{{/if}}
