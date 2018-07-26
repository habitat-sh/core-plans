# nginx

NGINX web server.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

### Default configuration

Without any configuration, the nginx service will serve static content from `/hab/svc/nginx/data/`. This directory is initially empty and can have any content copied or mounted into it.

### Redirect http to another service's https and do nothing else

```toml
redirector = true
```

### Force canonical hostname

```toml
[http.server]
name = "www.example.org"
canonicalize = true
```

### Custom root

```toml
[http.server.default_location]
root = "/opt/www"
```

### Custom index

```toml
[http.server.default_location]
index = "index.php"
```

### Extra config for `location /` block

```toml
[http.server.default_location]
extra_config = """\
        proxy_pass https://app1.example.org/;
"""
```

### Extra config for server block

```toml
[http.server]
extra_config = """\
        location /status/ {
            proxy_pass https://status1.example.org/;
        }
"""
```

Note: custom location blocks will not implement `http.server.canonicalize`,  canonicalization may be added manually when desired:

```toml
[http.server]
extra_config = """\
        location /status/ {
            if ($host != $server_name) {
                return 301 $scheme://$server_name$request_uri;
            }

            proxy_pass https://status1.example.org/;
        }
"""
```

### Extra config for http block

```toml
[http]
extra_config = """\
    upstream app {
        server app1.example.org;
        server app2.example.org;
    }
"""
```

### SSL via config

```toml

[http.server.ssl]
enable = true
certificate = '''
-----BEGIN CERTIFICATE-----
MII............................................................=
-----END CERTIFICATE-----

'''
key = '''
-----BEGIN RSA PRIVATE KEY-----
MII............................................................=
-----END RSA PRIVATE KEY-----
'''
```

### SSL via file path

```toml

[http.server.ssl]
enable = true
certificate_file = "/opt/www.example.org.crt"
key_file = "/opt/www.example.org.key"
```

### SSL via file upload

```toml

[http.server.ssl]
enable = true
```

```bash
hab file upload nginx.default 1 ./ssl.crt
hab file upload nginx.default 1 ./ssl.key
```
