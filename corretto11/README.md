[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.corretto11?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=221&branchName=master)

# corretto11

Amazon Corretto is a no-cost, multiplatform, production-ready distribution of the Open Java Development Kit (OpenJDK).  See [documentation](https://docs.aws.amazon.com/corretto/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/corretto11 as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/corretto11)

#### Runtime dependency

> pkg_deps=(core/corretto11)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/corretto11 --binlink``

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
$ hab pkg install core/corretto11 --binlink
» Installing core/corretto11
☁ Determining latest version of core/corretto11 in the 'stable' channel
→ Found newer installed version (core/corretto11/11.0.2.9.3/20200908134010) than remote version (core/corretto11/11.0.2.9.3/20200405194018)
→ Using core/corretto11/11.0.2.9.3/20200908134010
★ Install of core/corretto11/11.0.2.9.3/20200908134010 complete with 0 new packages installed.
» Binlinking javadoc from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked javadoc from core/corretto11/11.0.2.9.3/20200908134010 to /bin/javadoc
» Binlinking keytool from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked keytool from core/corretto11/11.0.2.9.3/20200908134010 to /bin/keytool
» Binlinking javac from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked javac from core/corretto11/11.0.2.9.3/20200908134010 to /bin/javac
» Binlinking jdeps from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jdeps from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jdeps
» Binlinking jcmd from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jcmd from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jcmd
» Binlinking jjs from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jjs from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jjs
» Binlinking jmod from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jmod from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jmod
» Binlinking jconsole from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jconsole from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jconsole
» Binlinking jimage from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jimage from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jimage
» Binlinking jps from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jps from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jps
» Binlinking rmic from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked rmic from core/corretto11/11.0.2.9.3/20200908134010 to /bin/rmic
» Binlinking jar from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jar from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jar
» Binlinking jlink from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jlink from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jlink
» Binlinking jstat from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jstat from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jstat
» Binlinking jinfo from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jinfo from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jinfo
» Binlinking jstack from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jstack from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jstack
» Binlinking jshell from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jshell from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jshell
» Binlinking unpack200 from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked unpack200 from core/corretto11/11.0.2.9.3/20200908134010 to /bin/unpack200
» Binlinking jdb from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jdb from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jdb
» Binlinking jdeprscan from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jdeprscan from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jdeprscan
» Binlinking java from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked java from core/corretto11/11.0.2.9.3/20200908134010 to /bin/java
» Binlinking rmiregistry from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked rmiregistry from core/corretto11/11.0.2.9.3/20200908134010 to /bin/rmiregistry
» Binlinking jarsigner from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jarsigner from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jarsigner
» Binlinking jaotc from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jaotc from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jaotc
» Binlinking rmid from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked rmid from core/corretto11/11.0.2.9.3/20200908134010 to /bin/rmid
» Binlinking jstatd from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jstatd from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jstatd
» Binlinking serialver from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked serialver from core/corretto11/11.0.2.9.3/20200908134010 to /bin/serialver
» Binlinking pack200 from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked pack200 from core/corretto11/11.0.2.9.3/20200908134010 to /bin/pack200
» Binlinking javap from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked javap from core/corretto11/11.0.2.9.3/20200908134010 to /bin/javap
» Binlinking jrunscript from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jrunscript from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jrunscript
» Binlinking jhsdb from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jhsdb from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jhsdb
» Binlinking jmap from core/corretto11/11.0.2.9.3/20200908134010 into /bin
★ Binlinked jmap from core/corretto11/11.0.2.9.3/20200908134010 to /bin/jmap
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/java -version`` or ``java -version``

```bash
$ java -version
openjdk version "11.0.2" 2019-01-15 LTS
OpenJDK Runtime Environment Corretto-11.0.2.9.3 (build 11.0.2+9-LTS)
OpenJDK 64-Bit Server VM Corretto-11.0.2.9.3 (build 11.0.2+9-LTS, mixed mode)
```
