#!/bin/bash

set -euo pipefail

TESTDIR="$(dirname "$0")"

TEST_PKG_IDENT="$1"

echo "MPFR is a library-only package. Please verify by building with DO_CHECK=true"
