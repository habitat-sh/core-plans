# Habitat Package: etcd
The Habitat Maintainers <humans@habitat.sh>

## Description

- [www](https://coreos.com/etcd)
- [Docs](https://coreos.com/etcd/docs/latest/)

> etcd is a distributed key value store that provides a reliable way to store data across a cluster of machines

- It’s open-source and available on GitHub.
- etcd gracefully handles leader elections during network partitions and will tolerate machine failure, including the leader.


## Usage

- On the first node: `hab sup start core/etcd --topology leader`
- On subsequent nodes: `hab sup start core/etcd --topology leader --peer <first node ip>`

On all nodes the following ports are available:

- **2379**: etcd client communication.
- **2380**: etcd server to server communication.

The ports can be changed.


On all nodes the following URLs are accessible:
- **listen-client-urls**: URLs to listen on for client traffic. Default to https://IP:2379
- **listen-peer-urls**: URLs to listen on for peer traffic. Default to https://IP:2380

The URLs can be changed.


### Testing with curl

- To create a key:
```
$ curl -L -X PUT -k https://10.0.2.15:2379/v2/keys/new -d value="Hello Habitat"
{"action":"set","node":{"key":"/new","value":"Hello Habitat","modifiedIndex":5,"createdIndex":5}}
```


- To read the key:
```
$ curl -L -k https://10.0.2.15:2379/v2/keys/new
{"action":"get","node":{"key":"/new","value":"Hello Habitat","modifiedIndex":5,"createdIndex":5}}
```


- To delete the key:
```
$ curl -L -X DELETE -k https://10.0.2.15:2379/v2/keys/new
{"action":"delete","node":{"key":"/new","modifiedIndex":6,"createdIndex":5},"prevNode":{"key":"/new","value":"Hello Habitat","modifiedIndex":5,"createdIndex":5}}
```


```
$ curl -L -k https://10.0.2.15:2379/v2/keys/new
{"errorCode":100,"message":"Key not found","cause":"/new","index":6}
```

## Notes

- This plan uses self-signed certificates with automatic generation. It assumes that
etcd is not exposed to outside world. The plan will be improved in next versions.

- hab v0.22/0.23 due to a bug in domain resolution inside these versions
of Habitat, etcd configuration is only using IP addresses to contact
other peers.
