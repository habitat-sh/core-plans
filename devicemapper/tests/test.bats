@test "Version matches" {
    version="$(echo ${PKGIDENT} | cut -d/ -f3)"
    result="$(hab pkg exec "${PKGIDENT}" vgs --version 2> /dev/null | grep -e 'LVM version' | awk '{print $3}' | awk '{gsub("[(][^)]*[)]","")}1')"
    [ "$result" = "${version}" ]
}
}
