#!/usr/bin/env bash
#
# pre-commit hook:
# Check for hook scripts that use `sleep` or that shell out to `hab`
#
# Authors:
# - Thom May <thom@chef.io>

# If we source files in our hook scripts, we need to check them too.
additional=()
sleeps=0
habs=0

# Obviously we shouldn't hit any missing sources, but it's easy enough to check
missing_source=()

file_check() {
  if [ ! -f $1 ]; then
    missing_source+=($1)
    return 1
  fi
  while read -r line; do
    # skip comments
    if [[ $line =~ ^\#.* ]]; then continue; fi

    # we're sourcing another file, so we need to check that file too
    if [[ $line =~ \..* ]]; then
      sourced=${line##. }
      additional+=($sourced)
      continue
    fi

    if [[ $line == *"sleep"* ]]; then
      sleeps=$((sleeps + 1))
      continue
    fi

    if [[ $line == *"hab "* ]]; then
      habs=$((habs + 1))
      continue
    fi
  done < $1
}

file_check $@

for file in ${additional[@]}; do
  file_check $file
done

if [[ $sleeps -gt 0 || $habs -gt 0 || ${#missing_source[@]} -gt 0 ]]; then
  files=$(printf ", %s" ${additional[@]})
  files=${files:2}
  echo "Error detected by Check Bad Patterns."
  echo "We checked $@ and $files."
  echo ""
  if [[ ${#missing_source[@]} -gt 0 ]]; then
    echo "  Found sourced files that don't exist: $missing_source"
    echo ""
  fi
  if [[ $sleeps -gt 0 ]]; then
    echo "  Found sleep $sleeps times in hook scripts"
    echo ""
  fi
  if [[ $habs -gt 0 ]]; then
    echo "  Found shell out to hab command $habs times"
    echo ""
  fi
  echo ""
  exit 1
fi

exit 0
