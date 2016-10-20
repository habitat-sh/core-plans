Redis 3.2.3 (and 3.2.4) introduced protected mode (forced authentication) by default, which means the leader election fails unless you authenticate. You can demo with a TOML file simlilar to this:
```
requirepass="abc123"
masterauth="abc123"
```

And inject it like this:

docker run -e HAB_REDIS="$(cat /tmp/redis.toml)" -it core/redis --topology leader
