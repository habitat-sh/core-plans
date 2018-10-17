#!/bin/bash
# Script to run when testing core-plans on Travis CI

echo "Setup Habitat Sudio"
export HAB_ORIGIN=travisci
hab origin key generate

echo "Attempting to build and test core-plans changes:"

while read -r line; do
  echo "${line}:"
  if [ ! -d "${line}" ]; then
    echo "Skipping ${line}: (not a directory)"
    continue
  fi

  if [ ! -d "${line}/tests" ]; then
    echo "Skipping ${line}: (no tests directory)"
    continue
  fi

  if [ ! -f "${line}/tests/test.sh" ]; then
    echo "Skipping ${line}: (no test.sh file)"
    continue
  fi

  hab studio run "${line}/tests/test.sh"
  result=$?
  if [ "${result}" -eq 1 ]; then
    echo "[FAIL] Exiting studio testing after test failure for ${line}"
    exit 1
  fi
done < <(git show --pretty=format: --name-only "$TRAVIS_COMMIT_RANGE"|grep -v "^$"|sort|uniq|grep "\/" | awk -F'/' '{print $1}'|sort|uniq)
