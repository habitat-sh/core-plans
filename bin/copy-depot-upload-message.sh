#!/bin/sh

# Take the last build information and put it into a message that you can paste
# into GitHub as a comment. Copy it to the clipboard.
source ./results/last_build.env
echo "[$pkg_ident](https://app.habitat.sh/#/pkgs/$pkg_ident) has been built and uploaded to the depot. :sparkling_heart:" | pbcopy
