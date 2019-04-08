# git

Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install the package and execute git.

On windows, `binlink` is not supported, so you can execute directly from the package:

```
hab pkg install core/git
hab pkg exec core/git git --help
```

On Linux you can do the same, or binlink and use the command directly:

```
hab pkg install core/git --binlink
git --help
```

If using this as a dependency from another plan, you can include as a build or runtime dependency, and it will be automatically included in the path as necessary:

```
pkg_deps=(core/git)
```

# Testing git on Linux/Mac

**Note**: The following manual steps can be performed in one automated step: [see these instructions](#run-the-tests-via-bash-script)

## Run the tests manually

### Build the git core plan

Ensure that:
* the [core-plan repo](https://github.com/habitat-sh/core-plans) is cloned locally
* a terminal is opened to the root of the repo

For example

```bash
git clone https://github.com/habitat-sh/core-plans.git
cd core-plans

# build git from its own directory
( cd git && hab pkg build . )
```

### Install the git core plan

Ensure that the terminal is located in the core-plans directory and a habitat studio is open.  Do the following steps:

```bash
# set environment from the last git build
source git/results/last_build.env

# install the git artifact
hab pkg install git/results/$pkg_artifact
```

Remain in the same habitat studio for the next section

### Run the tests

```bash
# install chef/inspec and dependency core/busybox
hab pkg install -b core/busybox
hab pkg install chef/inspec

# Create last_build.yml with pkg_ident attribute for inspec tests
sed -n "2,$ p" ./git/results/last_build.env | sed "s/=/: '/g" | sed "s/$/'/g" > ./git/results/last_build.yml

# run the tests
hab pkg exec chef/inspec inspec exec ./git/test --attrs ./git/results/last_build.yml
```

Sample output:

```bash
[7][default:/src:0]#  hab pkg exec chef/inspec inspec exec ./git/test --attrs ./git/results/last_build.yml

Profile: Habitat Core Plan git (git)
Version: 0.1.0
Target:  local://

  ✔  ensure git binary command works: Command: `/hab/pkgs/core/git/2.21.0/20190405093726/bin/git --help`
     ✔  Command: `/hab/pkgs/core/git/2.21.0/20190405093726/bin/git --help` stdout should match /usage: git/
     ✔  Command: `/hab/pkgs/core/git/2.21.0/20190405093726/bin/git --help` stderr should eq ""
     ✔  Command: `/hab/pkgs/core/git/2.21.0/20190405093726/bin/git --help` exit_status should eq 0
  ✔  ensure git binary exists: File /hab/pkgs/core/git/2.21.0/20190405093726/bin/git
     ✔  File /hab/pkgs/core/git/2.21.0/20190405093726/bin/git should exist


Profile Summary: 2 successful controls, 0 control failures, 0 controls skipped
Test Summary: 4 successful, 0 failures, 0 skipped
```

## Run the tests via bash script

Enter habitat studio  and choose one of the following options

1. To build git and test

   ```bash
   ./git/test/test.sh
   ```

2. To test an already built git

    ```bash
    SKIPBUILD=1 ./git/test/test.sh
    ```

# Testing git on Windows

**Note**: The following manual steps can be performed in one automated step: [see these instructions](#run-the-tests-via-powershell-script)

## Run the tests manually

### Build the git core plan

Ensure that:
* the [core-plan repo](https://github.com/habitat-sh/core-plans) is cloned locally
* a terminal is opened to the root of the repo

For example

```powershell
git clone https://github.com/habitat-sh/core-plans.git
cd core-plans

# build git from its own directory
$PLAN_ROOT = Join-Path -Path (Get-Location) -ChildPath "\git"
& { cd $PLAN_ROOT; hab pkg build . }
```

### Build and install the test plans

Ensure that the terminal is located in the core-plans directory and then do the following steps:

```powershell
# Load the habitat build variables
. $PLAN_ROOT\results\last_build.ps1

# install habitat package
$ARTIFACT = "$PLAN_ROOT\results\{0}" -f $pkg_artifact
hab pkg install $ARTIFACT
```

Remain in the same terminal for the next section

### Run the tests

```powershell
# install inspec for windows
hab pkg install -b stuartpreston/inspec

# Create last_build.yml with pkg_ident attribute for inspec tests
Out-File -FilePath $PLAN_ROOT\results\last_build.yml -Force
Add-Content $PLAN_ROOT\results\last_build.yml "pkg_ident: '$pkg_ident'"

# run the tests
inspec exec $PLAN_ROOT/test --attrs $PLAN_ROOT/results/last_build.yml
```

Sample output:

```powershell
PS C:\Users\azureuser\Documents\habitat\core-plans\git> inspec exec $PLAN_ROOT/test --attrs $PLAN_ROOT/results/last_buil
d.yml

Profile: Habitat Core Plan git (git)
Version: 0.1.0
Target:  local://

  [PASS]  ensure git binary exists: File c:/hab/pkgs/core/git/2.21.0/20190408213002/bin/git.exe
     [PASS]  File c:/hab/pkgs/core/git/2.21.0/20190408213002/bin/git.exe should exist
  [PASS]  ensure git binary command works: Command: `c:/hab/pkgs/core/git/2.21.0/20190408213002/bin/git.exe --help`
     [PASS]  Command: `c:/hab/pkgs/core/git/2.21.0/20190408213002/bin/git.exe --help` stdout should match /usage: git
/
     [PASS]  Command: `c:/hab/pkgs/core/git/2.21.0/20190408213002/bin/git.exe --help` stderr should eq ""
     [PASS]  Command: `c:/hab/pkgs/core/git/2.21.0/20190408213002/bin/git.exe --help` exit_status should eq 0


Profile Summary: 2 successful controls, 0 control failures, 0 controls skipped
Test Summary: 4 successful, 0 failures, 0 skipped
PS C:\Users\azureuser\Documents\habitat\core-plans\git>
```

## Run the tests via powershell script

Ensure terminal is open at "core-plans" and then choose one of the following options

1. To build git and test

   ```powershell
   ./git/test/test.ps1 -Skipbuild 0
   ```

2. To test an already built git

   ```powershell
   ./git/test/test.ps1 -Skipbuild 1
   ```