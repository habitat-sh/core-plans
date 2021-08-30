@test "Version matches" {
    # Ensure that `pkg_version` from the plan (embedded in the package
    # identifier) matches the output from `btrfs --version`.
    version="$(echo ${PKGIDENT} | cut -d/ -f3)"
    # `btrfs --version` inexplicably includes a space after the
    # version.
    expected_version="btrfs-progs v${version} "
    actual_version="$(hab pkg exec "${PKGIDENT}" btrfs --version)"
    diff <( echo "$actual_version" ) <( echo "${expected_version}" )
}
