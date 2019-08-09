# core-plans testing standard

Chef wants to ensure the highest level of quality and best developer experience for projects that choose to build their software with Habitat. Part of that goal is to set a standard for quality assurance in this repository.

## Motivation

    As a core-plans maintainer,
    I want to have basic testing for all core plans,
    so that core-plans is easier to maintain, and build issues do not manifest downstream.

## Specification

There are two aspects to this design:
 1. Defining the scope of testing that is appropriate for this project, and
 2. Defining how tests that are in scope will be implemented.

### Scope of Testing

It's essential to define and agree on the scope of testing. Testing must cover all aspects of quality that this repository is responsible for; and testing must also not exceed what the code in this repository does - if a failing test would not be fixed via a change to this repository, the test does not belong in this repository.

#### In-Scope for Testing

| **Task** | **Test** |
|---------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| Each Core Plan should build | Exits 0, outputs a .hart file |
| Each Core Package should install. | Pkg install |
| Core Plans with executables should produce valid executables. | Executable exists and executes in (at least) the most basic way e.g. `--help` |
| Core plans list their required runtime dependencies | Run a dependency checker tool on libraries and executables built by the plan (e.g. ldd or depends.exe) |
| The Core Plan builds the version stated in the plan file | Perform the software's version check and compare to the plan file |
| Plans with services should run with minimum viable configuration. | Working run, init, and reconfig hooks |
| Plans with services can upgrade a running instance of the previous release of that service. | Install the current stable version of the package from builder and run it with an upgrade strategy of `at-once`. |

#### Out-of-Scope for Testing

| **Assumptions** | **Exclusions** |
|---------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| Habitat is healthy | No tests exercising only Habitat |
| Upstream software takes care of its own quality | No tests beyond the do_check() hook passing in CI |
| Core Plans always aim to have minimal complexity | No complexity to the test scenarios beyond testing what the core plan is responsible for |
| Integration between Core Plan services is a higher level of testing that will come later | No integration testing. |


### Implementation of Automated Tests in core-plans

### CI configuration

core-plans currently has CI configuration to detect what plans have been modified and need tested ([see here](https://github.com/habitat-sh/core-plans/blob/master/.expeditor/generate_verify_pipeline.sh#L19)).
If a core plan has a `tests` directory, the contents should be run during CI for a Pull Request.


#### Proposal for CI

* CI will execute `tests/test.sh` and `tests/test.ps1` if either exists inside the directory of a plan that has been modified.
  * Some packages provide both a Linux and a Windows plan; so CI should have a build step for each.
* `tests/test.sh` or `tests/test.ps1` will not require any pre-installed software other than what is available on the CI build agent.
* For the time being, the build will not fail if `tests/test.sh` or `tests/test.ps1` does not exist.
  * Longer term, all plans will have some testing and new plans should not be accepted without them.
* The CI build will be marked failed if `tests/test.sh` or `tests/test.ps1` exits with a non-zero exit code.
* The tests will execute independently from the build - CI will build the package before calling `tests/test.sh` or `tests/test.ps1`, with the fully qualified package ident of the built package to test as a parameter.

#### Test implementation

* The standard testing programs used for core-plans are [BATS](https://github.com/sstephenson/bats) (for Linux) and [Pester](https://github.com/pester/Pester) (for Windows).
* Tests should not execute inside the same studio instance that the package was built in; to avoid cases where the software works only due to build dependencies being present.
 * Tests should run independently from the build and install of the package. The test script (`tests/test.sh` / `tests/test.ps1` ) will take the fully qualified package ident for a currently installed package as a parameter.
 * Tests for built binaries should use `hab pkg exec` to execute the binary. `hab pkg binlink` should not be used. See the [Appendix] for some examples to demonstrate why.

## Downstream Impact

There should be no negative downstream impacts. Builder will continue to build new unstable packages when commits are merged in this repository. It is intended that tests implemented according to this design can be run against artifacts on builder (or other downstream environments); but how that will actually happen is future work.

---

## Appendix

### Example - 7Zip

7Zip is used as an example because it has both Linux and Windows tests. Note that the plan builds different executables for Linux and Windows and therefore the tests differ.

#### Windows/Pester tests

Test launcher script `7zip/tests/test.ps1`:

```powershell
# Ensure package ident has been passed
param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Usage: test.ps1 [test_pgk_ident] e.g. test.ps1 core/7zip/16.04/20190513101258")
)

# Ensure Pester is installed
if (-Not (Get-Module -ListAvailable -Name Pester)) {
    hab pkg install core/pester
    Import-Module "$(hab pkg path core/pester)\module\pester.psd1"
}

# Install the package
hab pkg install $PackageIdentifier

# Test the package
$__dir=(Get-Item $PSScriptRoot)
$test_result = Invoke-Pester -PassThru -Script @{
    Path = "$__dir/test.pester.ps1";
    Parameters = @{PackageIdentifier=$PackageIdentifier}
}
Exit $test_result.FailedCount
```

Pester test file `7zip/tests/test.pester.ps1`:

```powershell
param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Describe "The 7z bin" {
    Context "7z invoked without options" {
        It "Runs and exits successfully" {
            hab pkg exec $PackageIdentifier 7z
            $? | Should be $true
        }
        It "Mentions the expected version number on stdout" {
            $expected_version = $PackageIdentifier.split("/")[2]
            $output = hab pkg exec $PackageIdentifier 7z
            $output | Out-String | Should -Match ".*7-Zip \[64\] ${expected_version}.*"
        }
    }
}
```

Running the tests:

```powershell
hab pkg build 7zip
. .\results\last_build.ps1
hab studio run -D "hab pkg install results/$pkg_artifact"
hab studio run -D "& 7zip/tests/test.ps1 $pkg_ident"
```

Sample output:

```powershell
PS C:\projects\core-plans> hab studio run "& ./7zip/tests/test.ps1 $pkg_ident"
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
1      Job1            BackgroundJob   Running       True            localhost            Microsoft.PowerShell.M...
core/7zip/16.04/20190513101258
» Installing core/7zip/16.04/20190513101258
→ Using core/7zip/16.04/20190513101258
≡ Install of core/7zip/16.04/20190513101258 complete with 0 new packages installed.
Executing all tests in 'C:\projects\core-plans\7zip\tests/test.pester.ps1'
Executing script C:\projects\core-plans\7zip\tests/test.pester.ps1
  Describing The 7z bin
    Context 7z invoked without options
      [+] Runs and exits successfully 278ms
      [+] Mentions the expected version number on stdout 207ms
Tests completed in 1.03s
Tests Passed: 2, Failed: 0, Skipped: 0, Pending: 0, Inconclusive: 0
```

#### Linux/BATS tests

Test launcher script `7zip/tests/test.sh`:

```bash
#!/bin/sh

#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/7zip/1.2.3/20181108151533
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
  exit 1
fi

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT

hab pkg install core/bats --binlink
hab pkg install "${TEST_PKG_IDENT}"

bats "$(dirname "${0}")"/test.bats
```

BATS test script `7zip/tests/test.bats`:

```bash
expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "7z exe runs" {
  run hab pkg exec ${TEST_PKG_IDENT} 7z
  [ ${status} -eq 0 ]
}

@test "7z version matches ${expected_version}" {
  run hab pkg exec "${TEST_PKG_IDENT}" 7z
  grep -Eo "7-Zip \[64\] ${expected_version}" <<< "${output}"
}

@test "7za exe runs" {
  run hab pkg exec ${TEST_PKG_IDENT} 7za
  [ ${status} -eq 0 ]
}

@test "7za version matches ${expected_version}" {
  run hab pkg exec "${TEST_PKG_IDENT}" 7za
  grep -Eo "7-Zip \(a\) \[64\] ${expected_version}"  <<< "${output}"
}
```

Running the tests:

```bash
hab pkg build 7zip
source results/last_build.env
hab studio run "./7zip/tests/test.sh ${pkg_ident}"
```

Sample output:

```
➜  core-plans git:(7zip) ✗ hab studio run "./7zip/tests/test.sh $pkg_ident"
   hab-studio: Importing 'core' secret origin key
» Importing origin key from standard input
★ Imported secret origin key core-20190311142149.
   hab-studio: Importing 'core' public origin key
» Importing origin key from standard input
★ Imported public origin key core-20190311142149.
   hab-studio: Exported: HAB_ORIGIN=core
» Installing core/bats
☁ Determining latest version of core/bats in the 'stable' channel
☛ Verifying core/bats/0.4.0/20190115015448
...
✓ Installed core/bats/0.4.0/20190115015448
★ Install of core/bats/0.4.0/20190115015448 complete with 1 new packages installed.
» Binlinking bats from core/bats/0.4.0/20190115015448 into /bin
★ Binlinked bats from core/bats/0.4.0/20190115015448 to /bin/bats
» Installing core/7zip/16.02/20190513161338
☛ Verifying core/7zip/16.02/20190513161338
...
✓ Installed core/7zip/16.02/20190513161338
★ Install of core/7zip/16.02/20190513161338 complete with 1 new packages installed.
1..4
ok 1 7z exe runs
ok 2 7z version matches 16.02
ok 3 7za exe runs
ok 4 7za version matches 16.02
```

### Examples of why `hab pkg exec` should be used

1. Missing dependencies can be masked

```
[16][default:/src:0]# cat bin/mysed
#!/bin/sh

sed "$@"
[17][default:/src:0]# cat plan.sh
pkg_name="mysed"
pkg_version="0.0.1"
pkg_bin_dirs=(bin)
do_build() { :; }
do_install() {
    cp $PLAN_CONTEXT/bin/mysed $pkg_prefix/bin/mysed
}

[14][default:/src:0]# hab pkg exec smacfarlane/mysed mysed --help
/hab/pkgs/smacfarlane/mysed/0.0.1/20190410152301/bin/mysed: line 3: sed: command not found

[15][default:/src:127]# /hab/pkgs/smacfarlane/mysed/0.0.1/20190410152301/bin/mysed --help
Usage: sed [OPTION]... {script-only-if-no-other-script} [input-file]...
```

2. The program may execute with a different PATH

```
[10][default:/src:1]# /hab/pkgs/core/coreutils/8.30/20190115012313/bin/env
...
PATH=/hab/pkgs/core/hab-plan-build/0.78.0/20190313122208/bin:/hab/pkgs/core/diffutils/3.6/20190115013221/bin:/hab/pkgs/core/less/530/20190115013008/bin:/hab/pkgs/core/make/4.2.1/20190115013626/bin:/hab/pkgs/core/mg/20180408/20190115015655/bin:/hab/pkgs/core/util-linux/2.32/20190115013746/bin:/hab/pkgs/core/vim/8.1.0577/20190115015449/bin:/hab/pkgs/core/ncurses/6.1/20190115012027/bin:/hab/pkgs/core/acl/2.2.53/20190115012136/bin:/hab/pkgs/core/attr/2.4.48/20190115012129/bin:/hab/pkgs/core/bash/4.4.19/20190115012619/bin:/hab/pkgs/core/binutils/2.31.1/20190115003743/bin:/hab/pkgs/core/bzip2/1.0.6/20190115011950/bin:/hab/pkgs/core/coreutils/8.30/20190115012313/bin:/hab/pkgs/core/file/5.34/20190115003731/bin:/hab/pkgs/core/findutils/4.6.0/20190115013303/bin:/hab/pkgs/core/gawk/4.2.1/20190115012752/bin:/hab/pkgs/core/glibc/2.27/20190115002733/bin:/hab/pkgs/core/grep/3.1/20190115012541/bin:/hab/pkgs/core/gzip/1.9/20190115013612/bin:/hab/pkgs/core/hab/0.78.0/20190313115951/bin:/hab/pkgs/core/libcap/2.25/20190115012150/bin:/hab/pkgs/core/openssl-fips/2.0.16/20190115014207/bin:/hab/pkgs/core/openssl/1.0.2r/20190305210149/bin:/hab/pkgs/core/pcre/8.42/20190115012526/bin:/hab/pkgs/core/rq/0.10.4/20190115014520/bin:/hab/pkgs/core/sed/4.5/20190115012152/bin:/hab/pkgs/core/tar/1.30/20190115012709/bin:/hab/pkgs/core/unzip/6.0/20190115014516/bin:/hab/pkgs/core/wget/1.19.5/20190305211748/bin:/hab/pkgs/core/xz/5.2.4/20190115013348/bin:/bin

[11][default:/src:0]# hab pkg exec core/coreutils env
...
PATH=/hab/pkgs/core/coreutils/8.30/20190115012313/bin:/hab/pkgs/core/glibc/2.27/20190115002733/bin:/hab/pkgs/core/acl/2.2.53/20190115012136/bin:/hab/pkgs/core/attr/2.4.48/20190115012129/bin:/hab/pkgs/core/libcap/2.25/20190115012150/bin
```

3. The program may not have required env vars

```
[14][default:/src:0]#  hab pkg exec core/ansible ansible --version
ansible 2.7.6
  config file = /hab/pkgs/core/ansible/2.7.6/20190305222954/etc/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /hab/pkgs/core/ansible/2.7.6/20190305222954/lib/python2.7/site-packages/ansible-2.7.6-py2.7.egg/ansible
  executable location = /hab/pkgs/core/ansible/2.7.6/20190305222954/bin/ansible
  python version = 2.7.15 (default, Mar  5 2019, 21:30:01) [GCC 8.2.0]

[16][default:/src:1]# hab pkg binlink core/ansible ansible
» Binlinking ansible from core/ansible into /bin
★ Binlinked ansible from core/ansible/2.7.6/20190305222954 to /bin/ansible
[17][default:/src:1]# ansible --version
Traceback (most recent call last):
  File "/bin/ansible", line 4, in <module>
    __import__('pkg_resources').run_script('ansible==2.7.6', 'ansible')
  File "/hab/pkgs/core/python2/2.7.15/20190305212819/lib/python2.7/site-packages/pkg_resources/__init__.py", line 3088, in <module>
    @_call_aside
  File "/hab/pkgs/core/python2/2.7.15/20190305212819/lib/python2.7/site-packages/pkg_resources/__init__.py", line 3072, in _call_aside
    f(*args, **kwargs)
  File "/hab/pkgs/core/python2/2.7.15/20190305212819/lib/python2.7/site-packages/pkg_resources/__init__.py", line 3101, in _initialize_master_working_set
    working_set = WorkingSet._build_master()
  File "/hab/pkgs/core/python2/2.7.15/20190305212819/lib/python2.7/site-packages/pkg_resources/__init__.py", line 574, in _build_master
    ws.require(__requires__)
  File "/hab/pkgs/core/python2/2.7.15/20190305212819/lib/python2.7/site-packages/pkg_resources/__init__.py", line 892, in require
    needed = self.resolve(parse_requirements(requirements))
  File "/hab/pkgs/core/python2/2.7.15/20190305212819/lib/python2.7/site-packages/pkg_resources/__init__.py", line 778, in resolve
    raise DistributionNotFound(req, requirers)
pkg_resources.DistributionNotFound: The 'ansible==2.7.6' distribution was not found and is required by the application
```
