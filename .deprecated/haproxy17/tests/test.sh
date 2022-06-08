#!/bin/sh
TESTDIR="$(dirname "${0}")"
"${TESTDIR}/../../haproxy19/tests/test.sh" "$@"
