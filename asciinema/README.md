# asciinema

asciinema lets you easily record terminal sessions and replay them in a terminal as well as in a web browser.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

[binary wrapper package](https://www.habitat.sh/docs/best-practices/#binary-wrapper)

## Usage

### Unix

```bash
hab pkg install core/asciinema
hab pkg exec core/asciinema asciinema --version
```

### Windows

```powershell
hab pkg install core/asciinema
hab pkg exec core/asciinema asciinema.cmd --version
```

## Testing

```
hab studio build asciinema
source results/last_build.env
hab studio run "./asciinema/tests/test.sh ${pkg_ident}"
```

## Sample Output

```
 ✓ Version matches
 ✓ Help command

2 tests, 0 failures
```
