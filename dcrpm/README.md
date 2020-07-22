# dcrpm

dcrpm ("detect and correct rpm") is a tool to detect and correct common issues
around RPM database corruption. It attempts a query against your RPM database
and runs db4's db_recover if it's hung or otherwise seems broken. It then kills
any jobs which had the RPM db open previously since they will be stuck in
infinite loops within libdb and can't recover cleanly.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

[binary wrapper package](https://www.habitat.sh/docs/best-practices/#binary-wrapper)

## Usage

### Unix

```bash
hab pkg install core/dcrpm
hab pkg binlink core/db db_recover
hab pkg binlink core/db db_stat
hab pkg binlink core/db db_verify
hab pkg binlink core/lsof lsof
hab pkg binlink core/rpm rpm
hab pkg exec core/dcrpm dcrpm --version
```

## Testing

```
hab studio build dcrpm
source results/last_build.env
hab studio run "./dcrpm/tests/test.sh ${pkg_ident}"
```

## Sample Output

```
 ✓ Version matches
 ✓ Help command

2 tests, 0 failures
```
