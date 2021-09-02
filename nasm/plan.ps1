$pkg_name="nasm"
$pkg_distname="$pkg_name"
$pkg_origin="core"
$pkg_version="2.15.05"
$pkg_description="The Netwide Assembler, NASM, is an 80x86 and x86-64 assembler designed for portability and modularity."
$pkg_upstream_url="http://www.nasm.us/"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("BSD-2-Clause")
$pkg_source="http://www.nasm.us/pub/$pkg_distname/releasebuilds/${pkg_version}/win64/$pkg_distname-${pkg_version}-win64.zip"
$pkg_shasum="f5c93c146f52b4f1664fa3ce6579f961a910e869ab0dae431bd871bdd2584ef2"
$pkg_bin_dirs=@("bin")

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_name-$pkg_version/*" "$pkg_prefix/bin" -Recurse -Force
}
