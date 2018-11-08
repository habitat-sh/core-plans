#!/bin/bash 

set -euo pipefail 

if [[ -z "${1:-}" ]]; then 
	echo "Usage: test.sh <fully qualified package ident>"
	echo 
	echo "ex: test.sh core/php/7.2.8/20181108151533"
	exit 1
fi

pkg_ident=${1}

# This depends on the package being present on the depot OR
# in your local cache. If you're testing locally this is a 
# reasonably safe assumption to make, as long as the cache 
# isn't cleaned aggressively 
hab pkg install $pkg_ident 

hab pkg exec $pkg_ident php "$(dirname $0)"/libzip_support.php 

