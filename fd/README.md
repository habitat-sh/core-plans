# fd

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

```bash
hab pkg install core/fd
hab pkg binlink core/fd

fd --version
```

## Testing

```
hab studio build fd
source results/last_build.env
hab studio run "./fd/tests/test.sh ${pkg_ident}"
```

## Sample Output

```
 ✓ Version matches
 ✓ Help command

2 tests, 0 failures
```
