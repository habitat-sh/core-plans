[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.corretto8?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=202&branchName=master)

# corretto8

Amazon Corretto is a no-cost, multiplatform, production-ready distribution of the Open Java Development Kit (OpenJDK).  See [documentation](https://docs.aws.amazon.com/corretto/)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/corretto8 as a dependency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/corretto8)

##### Runtime dependency

> pkg_deps=(core/corretto8)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/corretto8 --binlink``

will add the following binaries to the PATH:

* /bin/appletviewer
* /bin/extcheck
* /bin/idlj
* /bin/jar
* /bin/jarsigner
* /bin/java
* /bin/java-rmi.cgi
* /bin/javac
* /bin/javadoc
* /bin/javafxpackager
* /bin/javah
* /bin/javap
* /bin/javapackager
* /bin/jcmd
* /bin/jconsole
* /bin/jdb
* /bin/jdeps
* /bin/jhat
* /bin/jinfo
* /bin/jjs
* /bin/jmap
* /bin/jps
* /bin/jrunscript
* /bin/jsadebugd
* /bin/jstack
* /bin/jstat
* /bin/jstatd
* /bin/keytool
* /bin/native2ascii
* /bin/orbd
* /bin/pack200
* /bin/policytool
* /bin/rmic
* /bin/rmid
* /bin/rmiregistry
* /bin/schemagen
* /bin/serialver
* /bin/servertool
* /bin/tnameserv
* /bin/unpack200
* /bin/wsgen
* /bin/wsimport
* /bin/xjc

For example:

```bash
$ hab pkg install core/corretto8 --binlink
» Installing core/corretto8
☁ Determining latest version of core/corretto8 in the 'stable' channel
☛ Verifying core/corretto8/8.202.08.2/20200405000401
...
...
★ Install of core/corretto8/8.202.08.2/20200405000401 complete with 13 new packages installed.
» Binlinking javadoc from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked javadoc from core/corretto8/8.202.08.2/20200405000401 to /bin/javadoc
» Binlinking keytool from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked keytool from core/corretto8/8.202.08.2/20200405000401 to /bin/keytool
» Binlinking javac from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked javac from core/corretto8/8.202.08.2/20200405000401 to /bin/javac
» Binlinking jdeps from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jdeps from core/corretto8/8.202.08.2/20200405000401 to /bin/jdeps
» Binlinking javah from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked javah from core/corretto8/8.202.08.2/20200405000401 to /bin/javah
» Binlinking java-rmi.cgi from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked java-rmi.cgi from core/corretto8/8.202.08.2/20200405000401 to /bin/java-rmi.cgi
» Binlinking idlj from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked idlj from core/corretto8/8.202.08.2/20200405000401 to /bin/idlj
» Binlinking jcmd from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jcmd from core/corretto8/8.202.08.2/20200405000401 to /bin/jcmd
» Binlinking jjs from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jjs from core/corretto8/8.202.08.2/20200405000401 to /bin/jjs
» Binlinking appletviewer from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked appletviewer from core/corretto8/8.202.08.2/20200405000401 to /bin/appletviewer
» Binlinking jconsole from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jconsole from core/corretto8/8.202.08.2/20200405000401 to /bin/jconsole
» Binlinking jps from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jps from core/corretto8/8.202.08.2/20200405000401 to /bin/jps
» Binlinking xjc from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked xjc from core/corretto8/8.202.08.2/20200405000401 to /bin/xjc
» Binlinking javafxpackager from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked javafxpackager from core/corretto8/8.202.08.2/20200405000401 to /bin/javafxpackager
» Binlinking rmic from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked rmic from core/corretto8/8.202.08.2/20200405000401 to /bin/rmic
» Binlinking orbd from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked orbd from core/corretto8/8.202.08.2/20200405000401 to /bin/orbd
» Binlinking jsadebugd from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jsadebugd from core/corretto8/8.202.08.2/20200405000401 to /bin/jsadebugd
» Binlinking jar from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jar from core/corretto8/8.202.08.2/20200405000401 to /bin/jar
» Binlinking jstat from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jstat from core/corretto8/8.202.08.2/20200405000401 to /bin/jstat
» Binlinking jinfo from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jinfo from core/corretto8/8.202.08.2/20200405000401 to /bin/jinfo
» Binlinking jstack from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jstack from core/corretto8/8.202.08.2/20200405000401 to /bin/jstack
» Binlinking unpack200 from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked unpack200 from core/corretto8/8.202.08.2/20200405000401 to /bin/unpack200
» Binlinking jdb from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jdb from core/corretto8/8.202.08.2/20200405000401 to /bin/jdb
» Binlinking schemagen from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked schemagen from core/corretto8/8.202.08.2/20200405000401 to /bin/schemagen
» Binlinking java from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked java from core/corretto8/8.202.08.2/20200405000401 to /bin/java
» Binlinking rmiregistry from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked rmiregistry from core/corretto8/8.202.08.2/20200405000401 to /bin/rmiregistry
» Binlinking jhat from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jhat from core/corretto8/8.202.08.2/20200405000401 to /bin/jhat
» Binlinking jarsigner from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jarsigner from core/corretto8/8.202.08.2/20200405000401 to /bin/jarsigner
» Binlinking wsgen from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked wsgen from core/corretto8/8.202.08.2/20200405000401 to /bin/wsgen
» Binlinking wsimport from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked wsimport from core/corretto8/8.202.08.2/20200405000401 to /bin/wsimport
» Binlinking rmid from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked rmid from core/corretto8/8.202.08.2/20200405000401 to /bin/rmid
» Binlinking native2ascii from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked native2ascii from core/corretto8/8.202.08.2/20200405000401 to /bin/native2ascii
» Binlinking jstatd from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jstatd from core/corretto8/8.202.08.2/20200405000401 to /bin/jstatd
» Binlinking servertool from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked servertool from core/corretto8/8.202.08.2/20200405000401 to /bin/servertool
» Binlinking serialver from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked serialver from core/corretto8/8.202.08.2/20200405000401 to /bin/serialver
» Binlinking pack200 from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked pack200 from core/corretto8/8.202.08.2/20200405000401 to /bin/pack200
» Binlinking policytool from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked policytool from core/corretto8/8.202.08.2/20200405000401 to /bin/policytool
» Binlinking javap from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked javap from core/corretto8/8.202.08.2/20200405000401 to /bin/javap
» Binlinking javapackager from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked javapackager from core/corretto8/8.202.08.2/20200405000401 to /bin/javapackager
» Binlinking jrunscript from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jrunscript from core/corretto8/8.202.08.2/20200405000401 to /bin/jrunscript
» Binlinking extcheck from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked extcheck from core/corretto8/8.202.08.2/20200405000401 to /bin/extcheck
» Binlinking jmap from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked jmap from core/corretto8/8.202.08.2/20200405000401 to /bin/jmap
» Binlinking tnameserv from core/corretto8/8.202.08.2/20200405000401 into /bin
★ Binlinked tnameserv from core/corretto8/8.202.08.2/20200405000401 to /bin/tnameserv
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/java -version`` or ``java -version``

```bash
$ java -version
openjdk version "1.8.0_202"
OpenJDK Runtime Environment Corretto-8.202.08.2 (build 1.8.0_202-b08)
OpenJDK 64-Bit Server VM Corretto-8.202.08.2 (build 25.202-b08, mixed mode)
```
