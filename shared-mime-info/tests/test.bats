# The share-mime-info spec delcares that these files must be present 
# We should not validate the content, as that should come from upstream 
# tests and may change over time.
# We also skip the MEDIA/SUBTYPE.xml checks as that would produce a 
# extremely large number of checks that also may change over time
# https://specifications.freedesktop.org/share-mime-info-spec/share-mime-info-spec-0.18.html

@test "globs metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/globs ]
}

@test "globs2 metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/globs2 ]
}

@test "magic metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/magic ]
}

@test "subclasses metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/subclasses ]
}

@test "aliases metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/aliases ]
}

@test "icons metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/icons ]
}

@test "generic-icons metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/generic-icons ]
}

@test "XMLnamespaces metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/XMLnamespaces ]
}

@test "mime.cache metadata is generated" {
  [ -f /hab/pkgs/$TEST_PKG_IDENT/share/mime/mime.cache ]
}

