# openssh

## Maintainers

The Habitat Maintainers: <humans@habitat.sh>

## Usage

## Testing

**Note**: The following manual steps can be performed in one automated step: [see these instructions](#automate-the-build-and-test)

### Build the openssh core plan

Ensure that:
* the [core-plan repo](https://github.com/habitat-sh/core-plans) is cloned locally
* a terminal is opened to the root of the repo

For example

```bash
git clone https://github.com/habitat-sh/core-plans.git
cd core-plans

# build openssh from its own directory
( cd openssh && hab pkg build . )
```

Ensure that the terminal is located in the core-plans directory before proceeding

### Test the openssh core plan

Enter a habitat studio and perform the following steps (see [more information](#note)):

```bash
# set environment from the last openssh build
source openssh/results/last_build.env

# install the openssh artifact
hab pkg install openssh/results/$pkg_artifact

# load the openssh habitat service
hab svc load $pkg_ident
```

On successful load of the service, output will contain something like:

```bash
The core/openssh/7.5p1/20190327095344 service was successfully loaded
```

Remain in the same habitat studio for the next section

### Run the tests

```bash
# install inspec and dependency core/busybox
hab pkg install -b core/busybox
hab pkg install chef/inspec

hab pkg exec chef/inspec inspec exec ./openssh/test
```

Sample output:

```bash
[7][default:/src:0]# hab pkg exec chef/inspec inspec exec ./test

Profile: Habitat Core Plan openssh (openssh)
Version: 0.1.0
Target:  local://

  ✔  ensure openssh binary service works: Bash command /hab/pkgs/core/openssh/7.5p1/20190326193307/sbin/sshd  --help 2>&1
     ✔  Bash command /hab/pkgs/core/openssh/7.5p1/20190326193307/sbin/sshd  --help 2>&1 stdout should match /usage: sshd/
     ✔  Bash command /hab/pkgs/core/openssh/7.5p1/20190326193307/sbin/sshd  --help 2>&1 stderr should eq ""
  ✔  ensure openssh binary exists: File /hab/pkgs/core/openssh/7.5p1/20190326193307/sbin/sshd
     ✔  File /hab/pkgs/core/openssh/7.5p1/20190326193307/sbin/sshd should exist
  ✔  ensure sshd processes are all running and owned by correct owner: openssh processes
     ✔  openssh processes /sbin/sshd process running
     ✔  openssh processes /sbin/sshd should be owned by 'root'
  ✔  ensure openssh service is listening: Port 2222
     ✔  Port 2222 should be listening
     ✔  Port 2222 protocols should include "tcp"
     ✔  Port 2222 processes should include "sshd"


Profile Summary: 4 successful controls, 0 control failures, 0 controls skipped
Test Summary: 8 successful, 0 failures, 0 skipped
```

# Appendix

### Automate the build and test

Enter habitat studio  and choose one of the following options

1. To build openssh and test

   ```bash
   ./test/test.sh
   ```

2. To test an already built openssh

```bash
   SKIPBUILD=1 ./test/test.sh
```