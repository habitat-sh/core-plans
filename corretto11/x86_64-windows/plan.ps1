. "..\corretto\plan.ps1"

$pkg_name="corretto11"
$pkg_origin="core"
$pkg_version="11.0.14.10.1"
$pkg_description="Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon"
$pkg_upstream_url="https://aws.amazon.com/corretto/"
$pkg_license=@("GPLv2+CE")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://corretto.aws/downloads/resources/${pkg_version}/amazon-corretto-${pkg_version}-windows-x64-jdk.zip"
$pkg_shasum="f97c5d750322d9dc30428f1c3174abf94bf7f1c921305187759568a313ee950f"
