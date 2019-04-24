# tomcat-native

The Apache Tomcat Native Library is an optional component for use with Apache Tomcat that allows Tomcat to use certain native resources for performance, compatibility, etc.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

*TODO: Add instructions for usage*

## Testing

Run the tests/test.sh script withthe package built and installed and with `PACKAGE_IDENT` set:

```
hab studio enter
build tomcat-native
package_ident=$(cat results/last_build.env | grep pkg_ident | cut -d\= -f2)
./tomcat-native/tests/test.sh $package_ident
```

```
» Installing core/bats
☁ Determining latest version of core/bats in the 'stable' channel
→ Using core/bats/0.4.0/20190115015448
★ Install of core/bats/0.4.0/20190115015448 complete with 0 new packages installed.
» Binlinking bats from core/bats/0.4.0/20190115015448 into /bin
★ Binlinked bats from core/bats/0.4.0/20190115015448 to /bin/bats
 ✓ package directory for package ident core/tomcat-native/1.2.8/20190424103322 exists
 ✓ 'ldd /hab/pkgs/core/tomcat-native/1.2.8/20190424103322/lib/*.so*' indicates no dynamic linking issues

2 tests, 0 failures
```
