# journalbeat

Journalbeat is a lightweight shipper for journald logs with Elasticsearch.

## Maintainers

The Habitat Maintainers: <humans@habitat.sh>

## Type of package

Service package.

## Usage

```
hab svc load core/journalbeat
```

Journalbeat will run with the default configuration which puts logs at `{{svc_var_path}}/log/*.log`. The default configuration may not match your needs, and you can replace all of the configuration by providing a user.toml.

## Topologies

Recommended topology is `standalone`.

## Update Strategies

Recommended update strategy is `at-once`.
