@test "Version matches" {
    version="$(echo ${PKGIDENT} | cut -d/ -f3)"
    result="$(hab pkg exec "${PKGIDENT}" vgs --version 2> /dev/null | awk '/LVM version/ {print $3}' | awk '{gsub("[(][^)]*[)]","")}1')"
    [ "$result" = "${version}" ]
}

@test "Compiled with pkg-config support" {
    # If compiled with `pkg-config` support, we should find a
    # `pkg-config` metadata file in the package.
    [ -f "/hab/pkgs/${PKGIDENT}/lib/pkgconfig/devmapper.pc" ]
}
