# cerebro

Simple [Cerebro][1] installation.

## Maintainers

The Habitat Maintainers (humans@habitat.sh).

## Type of package

Service package.

## Usage

```
hab svc load core/cerebro
```

Browse to the node on port `9000` (default port).

Once open in your browser, enter the URI to your elasticsearch instance(s) to administer them.

## Bindings

Requires no binds in order to start. Default installation / service configuration will provide a URL input on browsing to the application, in which you can specify your ElasticSearch cluster IP / Hostname.

Exports `port`.

## Topologies

Recommended topology is `standalone`.

## Update strategies

Recommended update strategy is `at-once`.

## Notes

[Cerebro Github][1]

[1]: https://github.com/lmenezes/cerebro
