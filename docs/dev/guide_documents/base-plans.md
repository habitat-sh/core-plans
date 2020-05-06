# Base Plans 
The following plans are collectively known as the "base" plans. They are the 
the minimum set of packages required in order to build the Habitat cli, 
plan-build and the studio. Habitat is a self-hosting system; The build system, 
plan-build, is a Habitat package that depends on other Habitat packages to run.
Those packages were built with plan-build. If a change were to produce a studio 
or plan-build package that failed at run time, it would require manual 
intervention and builds to correct.  As such plans in this list require 
additional care when merging.

The base plans can be further divided into two groups. 

## The "Gang of 4X" #
These packages form a dependency cycle amongst themselves.
Ex: `a -> b -> c -> d -> a` 
In this example, rebuilding 'a' would rebuild 'b', and so on, until 'd', which 
would rebuild 'a', so special care must be taken to ensure the correct build order
and to know when it is safe to break out of the loop.

In addition, one or more of these plans are dependencies of nearly every other plan
in the 'core' origin, so changing any of them means building the 'core' origin in its
entirety. 

These packages should not be updated outside of a base plans refresh.

```
linux-headers
glibc
zlib
xz
pkg-config
ncurses
make
m4
gmp
gdbm
flex
findutils
diffutils
bzip2
attr
file
binutils
util-linux
procps-ng
bison
mpfr
patch
libcap
acl
libmpc
gawk
inetutils
sed
coreutils
gcc
gcc-libs
tcl
python-minimal
pcre
patchelf
gettext
db
expect
less
grep
perl
dejagnu
texinfo
automake
autoconf 
```

## The remainder 
These packages are generally safe to update in a normal builder workflow, but still
require additional care when updating. Updates to these plans should be coordinated 
with the Habitat team when possible.

If the dependencies of these plans change, which is rare but does happen, they should
be checked to see if it moves the plan in to the 'Gang of 4X' cycle. If it does, 
then that update should be made as part of the next base plans refresh.

```
shadow 
psmisc 
readline 
bash 
bc 
tar 
libtool 
gdbm 
expat 
iana-etc 
perl 
gzip 
expect 
dejagnu 
check 
libidn 
cacerts 
openssl
libiconv 
libunistring 
libidn2 
wget 
qnzip 
rq 
linux-headers-musl 
musl 
busybox-static 
zlib-musl 
bzip2-musl 
xz-musl 
libsodium-musl 
openssl-musl 
libarchive-musl 
rust
vim 
libbsd 
clens 
mg 
```

# Base plans refresh

The base plans refresh is a process though which updateds to critical packages, such as
glibc and gcc are made, which causes the entire `core` origin to need rebuilding. 

The process as it exists today is an artifact of Builder being unable to build on changes
to build dependencies (`pkg_build_deps`), in addition to being unable to handle the cycle
of the 'Gang of 4X'. Today, to update the base plans involved in a cycle, multiple builds
must be performed manually, in a specific order defined `base-plans.txt`. Once those builds
are complete, the remainder of core must be built offline against those packages, in 
a topologically sorted order base on run time dependencies.
 
In the near future, Builder will be able to handle building updates that will remove the 
need for the offline builds, allowing us to treat updates to packages such as `gcc` similar
to how we might update `redis`. However, there will still likely remain some ceremony around
updates to these packages, due to the scope of rebuilds and impact that they could have 
on the ecosystem. 
