# sed

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

*TODO: Add instructions for usage*

## Testing

`test/inspec` contains an InSpec profile that tests the last built executable.  
These tests require the last built package to be `hab pkg` installed and will intentionally fail if another build of sed is installed.  
To test the last built package:

 1. `hab studio enter`
 2. `source results/last_build.env`
 3. `hab pkg install "results/$pkg_artifact"`
 4. `hab pkg install chef/inspec`
 5. `hab pkg exec chef/inspec inspec exec test/inspec`
