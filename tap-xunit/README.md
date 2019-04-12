# tap-xunit

TAP to xUnit XML converter.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install the package

```
hab pkg install core/tap-xunit
```

Convert your test output!

```
echo "1..4
ok 1 - Input file opened
not ok 2 - First line of the input valid
ok 3 - Read the rest of the file
not ok 4 - Summarized correctly # TODO Not written yet" | hab pkg exec core/tap-xunit tap-xunit
```

Sample output:

```
<?xml version="1.0"?>
<testsuites>
  <testsuite tests="4" skipped="1" failures="1" errors="0" name="Default">
    <testcase name="#1 Input file opened"/>
    <testcase name="#2 First line of the input valid">
      <failure/>
    </testcase>
    <testcase name="#3 Read the rest of the file"/>
    <testcase name="#4 Summarized correctly">
      <skipped/>
    </testcase>
  </testsuite>
</testsuites>
```
