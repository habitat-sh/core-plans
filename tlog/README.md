# tlog

Tlog is a terminal I/O recording and playback package suitable for implementing
centralized user session recording.

## Maintainers

The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Binary package

## Usage

```
hab pkg install core/tlog
hab pkg binlink core/tlog

tlog-rec --writer=file --file-path=tlog.log

tlog-play --reader=file --file-path=tlog.log
```

## Testing

```
hab studio build tlog
source results/last_build.env
hab studio run "./tlog/tests/test.sh ${pkg_ident}"
```

## Sample Output

```
 ✓ Version matches
 ✓ tlog-play command
 ✓ tlog-rec command
 ✓ tlog-rec-session command

4 tests, 0 failure
```
