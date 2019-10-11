$pkg_name="asciinema"
$pkg_origin="core"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=('GPL-3.0-or-later')
$pkg_description="Terminal session recorder"
$pkg_upstream_url="https://github.com/asciinema/asciinema"
$pkg_deps=@(
  "core/python"
)
$pkg_bin_dirs=@("Scripts")

function pkg_version {
  python -m pip search --disable-pip-version-check $pkg_name | %{ if( $_ -match "^$pkg_name \((.+)\)") { $matches[1]; } }
}

function Invoke-Before {
  Set-PkgVersion
}

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
