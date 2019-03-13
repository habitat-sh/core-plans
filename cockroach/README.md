# CockroachDB

This plan provides for the installation of [Cockroach Labs](https://www.cockroachlabs.com)' [CockroachDB](https://github.com/cockroachdb/cockroach). It currently only replaces the installation step and does not provide any configuration management or supervision.

To get started, follow the [official getting started guide](https://www.cockroachlabs.com/docs/stable/start-a-local-cluster.html), substituting `hab pkg exec core/cockroach cockroach` in place of the bare `cockroach` command.

## Quick start

- Start single node:

    ```bash
    hab pkg exec core/cockroach cockroachoss start --insecure --host=localhost &
    ```
- Open web UI at http://localhost:8080
- Connect with included command-line SQL client:

    ```bash
    hab pkg exec core/cockroach cockroachoss sql --insecure
    ```
- Test some SQL:

    ```sql
    CREATE DATABASE bank;
    CREATE TABLE bank.accounts (id INT PRIMARY KEY, balance DECIMAL);
    INSERT INTO bank.accounts VALUES (1, 1000.50);
    SELECT * FROM bank.accounts;
    ```

- Quit the SQL client with the command `\q`

## Cluster

This plan supports running clustered CockroachDB by utilizing Habitat's native leader election. The leader is only used to establish the initial node in a minimum 3-node cluster, after that all nodes are able to accept reads and writes.

You can run an example cluster via docker-compose after exporting a docker container from this plan:
```
$ hab pkg export docker $(ls -1t results/*cockroach*.hart | head -1)
```

The docker post-process should create a docker image named `myorigin/cockroach` and it should be available on your local machine

example `docker-compose.yml` file:

```yaml
version: '2.4'
services:
  roach1:
    image: myorigin/cockroach:latest
    environment:
      HAB_COCKROACH: |
        insecure = false
    ports:
      - "8080:8080"
      - "26257:26257"
    mem_limit: 1g
    oom_kill_disable: true
    ulimits:
      nofile:
        soft: 15000
        hard: 30000
    command: --group cluster
      --topology leader

  roach2:
    image: myorigin/cockroach:latest
    environment:
      HAB_COCKROACH: |
        insecure = false
    ports:
      - "8081:8080"
      - "26258:26257"
    mem_limit: 1g
    oom_kill_disable: true
    ulimits:
      nofile:
        soft: 15000
        hard: 30000
    command: --peer roach1
      --group cluster
      --topology leader

  roach3:
    image: myorigin/cockroach:latest
    environment:
      HAB_COCKROACH: |
        insecure = false
    ports:
      - "8082:8080"
      - "26259:26257"
    mem_limit: 1g
    oom_kill_disable: true
    ulimits:
      nofile:
        soft: 15000
        hard: 30000
    command: --peer roach1
      --group cluster
      --topology leader
```

## Binding

You may bind to any CockroachDB node in the service group, not just the leader - all nodes are able to accept reads and writes
