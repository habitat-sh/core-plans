#!/bin/sh
TESTDIR="$(dirname "${0}")"
"${TESTDIR}/../../haproxy/tests/test.sh" "$@"
