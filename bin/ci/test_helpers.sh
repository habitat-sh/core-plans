# This file is a collection of commonly used functions in testing core-plans

# Attempts to start a supervisor.
# Detects if a supervisor is already running and emits a warning if one is found
# Shares logging path with the studio supervisor.
# This is to allow local testing of packages, which will likely happen in a
# studio, to behave as close as possible to CI.
ci_ensure_supervisor_running() {
  # We can't use `hab sup status` as the exit code for `not running` vs.
  # `running but recieved an error` is the same. In the case of the later
  # we'll catch the error in the retry logic that ensures the supervisor
  # is running before handing control back to the tests
  #
  # The studio doesn't contain ps by default so we need to use the presence
  # of the LOCK file to attempt to determine if the supervisor is running.
  #
  # Failure case: Supervisor is stopped, but LOCK file is still present
  if [ -f /hab/sup/default/LOCK ]; then
    echo "--- :warning: Supervisor LOCK file found, not starting the supervisor"
  else
    echo "--- :habicat: Starting the supervisor"
    if [ ! -f /hab/sup/default/sup.log ]; then
      mkdir -p /hab/sup/default
      touch /hab/sup/default/sup.log
    fi
    hab sup run > /hab/sup/default/sup.log 2>&1 &
  fi

  for retry in {1..20}; do
    sleep 1
    hab sup status > /dev/null 2>&1 && break
    echo "Waiting for Supervisor to start: $retry"
  done

  if [ "$retry" -eq 5 ]; then
    echo "--- :boomboom: Unable to connect to supervisor"
    exit 1
  fi
}

# Loads the specified service
# Retries until the service shows running or it specified timeout (default 5 seconds)
# period has passed.
ci_load_service() {
  service="$1"
  timeout="${2:-5}"

  echo "--- :habicat: Loading service $service"
  hab svc load "$service"

  for retry in $(seq 1 "$timeout"); do
    sleep 1
    state="$(hab svc status | grep $service |awk '{print $4}')"
    if [ "$state" == "up" ]; then
      break
    fi
    echo "Waiting for $service to start: $retry"
  done

  if [ "$retry" -eq "$timeout" ]; then
    echo "--- :boomboom: Unable to load service $service"
    exit 1
  fi
}
