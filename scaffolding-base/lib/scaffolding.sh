# # Scaffolding Base
#
# Habitat Scaffolding used to generate Scaffolding
#
# A scaffolding in Habitat is a plan you reference in your plan with:
#
#     pkg_scaffolding="core/scaffolding-python"
#
# When doing this, you plan will now have properties and use callbacks to build
# your plan that use features and established patterns of the platform for
# which the scaffolding was made.
#
# Plans to make scaffolding are all very similar:
#
# * Since the scaffolding is located in the plan itself, don't do download,
#   verify, or unpack.
# * Don't do anything with build; we're only copying a file.
# * For install, put $PLAN_CONTEXT/lib/scaffolding.sh into the package.
#
# The base scaffolding does this, to use it add:
#
#     pkg_scaffolding="core/scaffolding-base"
#
# to your plan and make sure there is a lib/scaffolding.sh present. Building a
# plan using this scaffolding will produce a scaffolding that can be used in
# other plans.

# lib/scaffolding.sh and supporting files are stored in the package with the
# plan. This means we don't have to download, verify, or unpack. Future
# versions of Habitat (after 0.20.0) may not need these functions disabled.
do_default_download() {
  return 0
}

do_default_verify() {
  return 0
}

do_default_unpack() {
  return 0
}

# Just installing some shell scripts, no build to do here.
do_default_build() {
  return 0
}

# Install lib/scaffolding.sh from the plan into the package.
do_default_install() {
  install -D -m 0644 "$PLAN_CONTEXT/lib/scaffolding.sh" "$pkg_prefix/lib/scaffolding.sh"
}
