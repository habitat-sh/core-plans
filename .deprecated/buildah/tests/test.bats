@test "Version matches" {
    # Ensure that `pkg_version` from the plan (embedded in the package
    # identifier) matches the output from `buildah --version`.
    version="$(echo ${PKGIDENT} | cut -d/ -f3)"
    result="$(hab pkg exec "${PKGIDENT}" buildah --version)"
    # The full output will look something like this:
    #     buildah version 1.14.8 (image-spec 1.0.1-dev, runtime-spec 1.0.1-dev)
    [[ "$result" =~ "buildah version ${version}" ]]
}
