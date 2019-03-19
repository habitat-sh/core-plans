# sed

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

*TODO: Add instructions for usage*

## Testing

To test the last built package:

 1. `hab studio enter`
 2. `source results/last_build.env`
 3. `hab pkg install -b "results/$pkg_artifact"`
 4. `hab pkg install -b chef/inspec`
 5. `inspec exec test/inspec`
