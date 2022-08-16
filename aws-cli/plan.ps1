$pkg_name="aws-cli"
$pkg_origin="core"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=('Apache-2.0')
$pkg_description="The AWS Command Line Interface (CLI) is a unified tool to \
  manage your AWS services. With just one tool to download and configure, you \
  can control multiple AWS services from the command line and automate them \
  through scripts."
$pkg_upstream_url="https://aws.amazon.com/cli/"
$pkg_deps=@(
    "core/python"
)
$pkg_bin_dirs=@("Scripts")

function pkg_version {
    # Replaced 'pip search' with an Invoke-WebRequest to the RSS XML for the awscli package
    # since PyPl XMLRPC has been permanantly disabled (see https://status.python.org/). By taking
    # the first element in the list, we always ensure we have the latest version
    $output = (Invoke-WebRequest -UseBasicParsing -Uri 'https://pypi.org/rss/project/awscli/releases.xml').Content
    return ([xml]$output).rss.channel['item'].title
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
    python -m pip install "awscli==$pkg_version"
    # Write out versions of all pip packages to package
    python -m pip freeze > "$pkg_prefix/requirements.txt"
}
