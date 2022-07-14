@test "Version matches" {
    # Ensure that `pkg_version` from the plan (embedded in the package
    # identifier) matches the output from `runc --version`.
    version="$(echo ${PKGIDENT} | cut -d/ -f3)"
    result="$(runc --version | head -n1)"
    [ "$result" = "runc version ${version}" ]
}

@test "Binary is statically compiled" {
    # The output of `file` will contain (among other data) the
    # string "statically linked" or "dynamically linked"; we want the former.
    result="$(hab pkg exec core/file file /hab/pkgs/"${PKGIDENT}"/bin/runc)"
    [[ "$result" =~ "statically linked" ]]
}

@test "Compiled with libseccomp support" {
    # There may be better ways of determining this, but a version with
    # libseccomp support will include numerous strings pointing to the
    # Go seccomp library; one that hasn't been so compiled will *not*
    # include these, but will instead include references to indicate
    # seccomp is not supported.
    result="$(hab pkg exec core/binutils strings /hab/pkgs/${PKGIDENT}/bin/runc)"
    [[ "$result" =~ "github.com/opencontainers/runc/vendor/github.com/seccomp/libseccomp-golang" ]]
    ! [[ "$result" =~ "github.com/opencontainers/runc/libcontainer/seccomp/seccomp_unsupported.go" ]]
}
