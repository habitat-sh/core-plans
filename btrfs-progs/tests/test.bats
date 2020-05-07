@test "Version matches" {
    # Ensure that `pkg_version` from the plan (embedded in the package
    # identifier) matches the output from `btrfs --version`.
    version="$(echo ${PKGIDENT} | cut -d/ -f3)"
    result="$(hab pkg exec "${PKGIDENT}" btrfs --version)"
    # Using `=~` operator rather than `=` because `btrfs --version`
    # inexplicably includes a space after the version.
    [[ "$result" =~ "btrfs-progs v${version}" ]]
}
