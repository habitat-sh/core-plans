# visual-cpp-build-tools-2015

Standalone compiler, libraries and scripts

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

To use these build tools in another plan, please use the provided `setenv.ps1` script to set the appropriate environment variables before you build your software.

Example:

```
function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}
```
