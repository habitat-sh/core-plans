# libfcgi

FastCGI is a language independent, scalable, open extension to CGI that provides high performance without the limitations of server specific APIs.

This package contains library and include files, as well as the `cgi-fcgi` binary that can be used on execute FastCGI requests via command line.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

Execute a FastCGI request directly against PHP-FPM:

```bash
SCRIPT_NAME="/status" \
SCRIPT_FILENAME="/status" \
REQUEST_METHOD="GET" \
    cgi-fcgi \
        -bind \
        -connect 127.0.0.1:9000
```
