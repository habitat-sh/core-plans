# Don't attempt to build the following plans. They have resource requirements
# or build times that exceed the currently available resources on our CI
# infrastructure.
$PLAN_BLACKLIST=@(
 "ghc"
 "ghc710"
 "ghc710-bootstrap"
 "ghc80"
 "ghc82"
 "ghc82-bootstrap"
 "ghc84"
 "ghc86"
)

$plan = $args[0]

$env:HAB_ORIGIN="ci"

ForEach( $bl in $PLAN_BLACKLIST ) { 
  if ( $plan -eq $bl ) { 
    Write-Host "--- :bangbang: [$plan] Skipping build"
    # If we're running in buildkite, we also want to annotate the build
    if ( $CI -eq "true" ) {
      buildkite-agent annotate --style 'warning' ":bangbang: ${plan} found in build blacklist. Skipping build."
    }
    exit 0;
  }
}


Write-Host "--- :key: Generating fake origin key"
# This is intended to be run in the context of public CI where
# we won't have access to any valid signing keys. j
hab origin key generate "$HAB_ORIGIN"


Write-Host "--- :construction: Starting build for $plan"
# Build with DO_CHECK=true.
# There are a number of plans that have false-positive tests
# or "known failing" tests that are currently ignored by maintainers
# For now this script will be non-enforcing and will always
# return success. It will be on the maintainers to verify the build
# and determine if any failures need correction.  In the future
# this will be turned into an enforcing script, preventing merges
# if do_check produces any failures.

$project_root = git rev-parse --show-toplevel

Push-Location "$project_root"
try {
  # TODO(SM): This appears to not work the same as our linux client, 
  # and DO_CHECK isn't forwarded into the build environment. This may be 
  # a function of my lack of Windows/Powershell knowledge.
  # There are no Invoke-Checks in core-plans currently, so this is ok for now.
  # TODO(SM): There are some subtle difference on how exit codes work. The 
  # below appears to work if the build fails, but will pass if you `exit 1` in 
  # one of the callbacks.
  $env:DO_CHECK="true"
  hab pkg build "$plan"
} finally { 
  Pop-Location 
  Remove-Item Env:\DO_CHECK
}

if ( $LastExitCode -ne 0 ) {
  Write-Host "--- :rotating_light: :rotating_light: :rotating_light: BUILD FAILED :rotating_light: :rotating_light: :rotating_light:"
}

exit 0
