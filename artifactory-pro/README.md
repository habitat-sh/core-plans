# Habitat package: artifactory-pro

Artifactory is an advanced Binary Repository Manager for use by build tools (like Maven and Gradle), dependency management tools (like Ivy and NuGet) and build servers (like Jenkins, Hudson, TeamCity and Bamboo).

## Maintainers

* [Christopher P. Maher](https://github.com/defilan)

## Type of Package

Service package

## Usage

This application runs Artifactory Pro. In order to sucessfully stand up Artifactory Pro, you must provide a valid
license key in your config.

By default, Artifactory Pro is set to use an internal derby database with a native jdbc driver. Other DB systmes can be
used, such as MSSQL, Oracle, PosgreSQL, and MySQL. Please refer to Artifactory Pro documentation(https://www.jfrog.com/confluence/display/RTF/Configuring+the+Database) for more information.

## Topologies

### Standalone
Unless you have a license for Artifactory Pro HA (Enterprise License(https://jfrog.com/pricing)), it is highly
recommended you run this using the standalone topology.

```text
hab start core/artifactory-pro
```

## Update Strategies

The recommended update strategy is `rolling` in a HA setup. However, it can be `at-once` in standalone.
