#!/bin/bash
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

echo "This package is intended only for use with build glibc."
echo "Please verify any changes to this by building glibc with the updated version of this package."
