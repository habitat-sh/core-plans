# Xorg Maintainer README

## Current State

X is composed of a large number of packages, the majority of which are
not packaged. The current goal is to finish the libraries required
for building client applications. The end goal is to have a fully
functional Xorg distribution, including the client and server.

## Conventions

When packaging the X related packages, please keep the following
conventions in mind:

- Downcase all package names for consistency

- Packages should be downloaded from
  https://www.x.org/releases/individual/ using the latest available
  version

- Add any new packages to the xorg_build_order file to make local
  development easier. While the build-service handles this for us
  during the real build it is occasionally useful to build a large
  number of the X packages locally.

## Priority TODO List

- [ ] Finish plans all packages in the proto/ folder (https://www.x.org/releases/individual/proto/)
- [ ] Finish plans for font-related packages.
- [ ] Build xorg-server and any remaining missing dependencies (see
  https://github.com/stevendanna/habitat-plans/issues/5#issuecomment-335787378
  for some useful guidance)
