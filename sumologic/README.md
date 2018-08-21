# Habitat package: sumologic

## Description

[Sumologic](1) is a cloud-based log management and analytics service. This plan configures a Sumologic Collector.

This plan provides the static binary for execution.

Important Note: For this application to work, you must provide your Sumologic accessid
and accesskey.

## Usage

```
hab svc load core/sumologic
hab svc start core/sumologic
```

## Topology

Sumologic Collector is a Java agent that receives logs and metrics from its Sources and then encrypts, compresses, and sends the data to the Sumo service. As its name implies, an Installed Collector is installed in your environment, as opposed to a Hosted Collector, which resides on the Sumo service. After installing a Collector, you add Sources, to which the Collector connects to obtain data to send to the Sumo service.

The `standalone` topology would be the most typical use for this application

## Update Strategy

Recommended update strategy for Sumologic is `rolling`.

[1]: https://www.sumologic.com
