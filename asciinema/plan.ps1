$pkg_name="asciinema"
$pkg_origin="core"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=('GPL-3.0-or-later')
$pkg_description="Terminal session recorder"
$pkg_upstream_url="https://github.com/asciinema/asciinema"
$pkg_version = '2.0.1'
$pkg_deps=@(
    "core/python"
)
$pkg_bin_dirs=@("Scripts")

# We currently cannot use the latest version '2.0.2', since it requires
# the fcntl package, which is unavailable on Windows. Once we can use the
# latest version again, the below code can be uncommented and the above
# $pkg_version = '2.0.1' can be removed

# function pkg_version {
#     $output = (Invoke-WebRequest -UseBasicParsing -Uri "https://pypi.org/rss/project/$($pkg_name)/releases.xml").Content
#     return ([xml]$output).rss.channel['item'].title
# }

# function Invoke-Before {
#     Set-PkgVersion
# }

function Invoke-Prepare {
    python -m pip install virtualenv
    python -m virtualenv "$pkg_prefix"
    ."$pkg_prefix/Scripts/activate"
}

function Invoke-Install {
    python -m pip install "$pkg_name==$pkg_version"
    # Write out versions of all pip packages to package
    python -m pip freeze > "$pkg_prefix/requirements.txt"
}
