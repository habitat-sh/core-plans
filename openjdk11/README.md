[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.openjdk11?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=275&branchName=master)

# openjdk11

OpenJDK is a free and open-source implementation of the Java Platform, Standard Edition. It is the result of an effort Sun Microsystems began in 2006. The implementation is licensed under the GNU General Public License version 2 with a linking exception.  See [documentation](https://openjdk.java.net)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/openjdk11 as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/openjdk11)

#### Runtime dependency

> pkg_deps=(core/openjdk11)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/openjdk11 --binlink``

will add the following binaries to the PATH:

* /bin/jaotc
* /bin/jar
* /bin/jarsigner
* /bin/java
* /bin/javac
* /bin/javadoc
* /bin/javap
* /bin/jcmd
* /bin/jconsole
* /bin/jdb
* /bin/jdeprscan
* /bin/jdeps
* /bin/jhsdb
* /bin/jimage
* /bin/jinfo
* /bin/jjs
* /bin/jlink
* /bin/jmap
* /bin/jmod
* /bin/jps
* /bin/jrunscript
* /bin/jshell
* /bin/jstack
* /bin/jstat
* /bin/jstatd
* /bin/keytool
* /bin/pack200
* /bin/rmic
* /bin/rmid
* /bin/rmiregistry
* /bin/serialver
* /bin/unpack200

For example:

```bash
$ hab pkg install core/openjdk11 --binlink
Installing core/openjdk11
☁ Determining latest version of core/openjdk11 in the 'stable' channel
→ Found newer installed version (core/openjdk11/11.0.2/20200929091217) than remote version (core/openjdk11/11.0.2/20200404235521)
→ Using core/openjdk11/11.0.2/20200929091217
★ Install of core/openjdk11/11.0.2/20200929091217 complete with 0 new packages installed.
» Binlinking javadoc from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked javadoc from core/openjdk11/11.0.2/20200929091217 to /bin/javadoc
» Binlinking keytool from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked keytool from core/openjdk11/11.0.2/20200929091217 to /bin/keytool
» Binlinking javac from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked javac from core/openjdk11/11.0.2/20200929091217 to /bin/javac
» Binlinking jdeps from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jdeps from core/openjdk11/11.0.2/20200929091217 to /bin/jdeps
» Binlinking jcmd from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jcmd from core/openjdk11/11.0.2/20200929091217 to /bin/jcmd
» Binlinking jjs from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jjs from core/openjdk11/11.0.2/20200929091217 to /bin/jjs
» Binlinking jmod from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jmod from core/openjdk11/11.0.2/20200929091217 to /bin/jmod
» Binlinking jconsole from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jconsole from core/openjdk11/11.0.2/20200929091217 to /bin/jconsole
» Binlinking jimage from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jimage from core/openjdk11/11.0.2/20200929091217 to /bin/jimage
» Binlinking jps from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jps from core/openjdk11/11.0.2/20200929091217 to /bin/jps
» Binlinking rmic from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked rmic from core/openjdk11/11.0.2/20200929091217 to /bin/rmic
» Binlinking jar from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jar from core/openjdk11/11.0.2/20200929091217 to /bin/jar
» Binlinking jlink from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jlink from core/openjdk11/11.0.2/20200929091217 to /bin/jlink
» Binlinking jstat from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jstat from core/openjdk11/11.0.2/20200929091217 to /bin/jstat
» Binlinking jinfo from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jinfo from core/openjdk11/11.0.2/20200929091217 to /bin/jinfo
» Binlinking jstack from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jstack from core/openjdk11/11.0.2/20200929091217 to /bin/jstack
» Binlinking jshell from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jshell from core/openjdk11/11.0.2/20200929091217 to /bin/jshell
» Binlinking unpack200 from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked unpack200 from core/openjdk11/11.0.2/20200929091217 to /bin/unpack200
» Binlinking jdb from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jdb from core/openjdk11/11.0.2/20200929091217 to /bin/jdb
» Binlinking jdeprscan from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jdeprscan from core/openjdk11/11.0.2/20200929091217 to /bin/jdeprscan
» Binlinking java from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked java from core/openjdk11/11.0.2/20200929091217 to /bin/java
» Binlinking rmiregistry from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked rmiregistry from core/openjdk11/11.0.2/20200929091217 to /bin/rmiregistry
» Binlinking jarsigner from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jarsigner from core/openjdk11/11.0.2/20200929091217 to /bin/jarsigner
» Binlinking jaotc from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jaotc from core/openjdk11/11.0.2/20200929091217 to /bin/jaotc
» Binlinking rmid from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked rmid from core/openjdk11/11.0.2/20200929091217 to /bin/rmid
» Binlinking jstatd from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jstatd from core/openjdk11/11.0.2/20200929091217 to /bin/jstatd
» Binlinking serialver from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked serialver from core/openjdk11/11.0.2/20200929091217 to /bin/serialver
» Binlinking pack200 from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked pack200 from core/openjdk11/11.0.2/20200929091217 to /bin/pack200
» Binlinking javap from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked javap from core/openjdk11/11.0.2/20200929091217 to /bin/javap
» Binlinking jrunscript from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jrunscript from core/openjdk11/11.0.2/20200929091217 to /bin/jrunscript
» Binlinking jhsdb from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jhsdb from core/openjdk11/11.0.2/20200929091217 to /bin/jhsdb
» Binlinking jmap from core/openjdk11/11.0.2/20200929091217 into /bin
★ Binlinked jmap from core/openjdk11/11.0.2/20200929091217 to /bin/jmap
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/java --version`` or ``java --version``

```bash
$ java --version
openjdk 11.0.2 2019-01-15
OpenJDK Runtime Environment 18.9 (build 11.0.2+9)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.2+9, mixed mode)
```
