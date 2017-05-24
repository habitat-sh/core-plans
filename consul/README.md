 ## Clustered Consul

Consul provides its own leader election and gossip mechanism so the purpose of this plan is to provide a light weight wrapper that allows Consul to be integrated in to habitat based deployments and ecosystems. The primary benefit provided here is that Habitat, via supervisor, will keep track of all nodes in the cluster and pass config changes when new members are added or removed.


## Adding a node to the cluster

When you run a plan with the `--peer`  flag and the appropriate service group,  all other nodes in the group will be added to the join/retry key in the Consul config. Consul will reach Quorum when `bootstrap_expect` is reached based on the number of consul nodes that have joined the service group.

## Running Tests via Delmo
Delmo can be found here https://github.com/bodymindarts/delmo and the test suite can be run
from the root of the plan directory.

`delmo -f delmo.yml`

## Docker example with Human Scheduler
#### First node
```bash
docker run -it starkandwayne/consul  --group consul-test
```

#### nth-node node
```bash
docker run -it starkandwayne/consul  --group consul-test --peer <ip of node 1>
```

Once bootstrap-expect is satisfied, the cluster will elect a leader.

#### Enabling UI and/or REST API
inorder to allow outside connections you will need to set
```
client.bind = "<nodes public interface>"
```

### Security

In the `default.toml` We have provided a default Gossip Encryption Key, SSL Cert, CA Cert, and a private key. If you want to make your consul deployment secure, make sure to provide your own values for those fields.

More information on [Consul Encryption](https://www.consul.io/docs/agent/encryption.html)
