# lgpo

This package provides the LGPO binaries

[LGPO](https://blogs.technet.microsoft.com/secguide/2016/01/21/lgpo-exe-local-group-policy-object-utility-v1-0/) is a command-line utility to automate the management of local group policy.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

[binary wrapper packages](https://www.habitat.sh/docs/best-practices/#binary-wrapper-packages)

## Usage

LGPO.exe can be used to apply local group policies to a machine using habitat

```
$ hab pkg install core/lgpo
$ hab pkg binlink core/lgpo
$ LGPO.exe

LGPO.exe v2.2 - Local Group Policy Object utility

LGPO.exe has four modes:
  * Import and apply policy settings;
  * Export local policy to a GPO backup;
  * Parse a registry.pol file to "LGPO text" format;
  * Build a registry.pol file from "LGPO text".

To apply policy settings:

    LGPO.exe command [...]

    where "command" is one or more of the following (each of which can be repeated):

    /g path                import settings from one or more GPO backups under "path"
    /m path\registry.pol   import settings from registry.pol into machine config
    /u path\registry.pol   import settings from registry.pol into user config
    /ua path\registry.pol  import settings from registry.pol into user config for Administrators
    /un path\registry.pol  import settings from registry.pol into user config for Non-Administrators
    /u:username path\registry.pol
                           import settings from registry.pol into user config for local user
                           specified by "username"
    /s path\GptTmpl.inf    apply security template
    /a[c] path\Audit.csv   apply advanced auditing settings; /ac to clear policy first
    /t path\lgpo.txt       apply registry commands from LGPO text
    /e <name>|<guid>       enable GP extension for local policy processing; specify a
                           GUID, or one of these names:
                           * "zone" for IE zone mapping extension
                           * "mitigation" for mitigation options, including font blocking
                           * "audit" for advanced audit policy configuration
                           * "LAPS" for Local Administrator Password Solution
                           * "DGVBS" for Device Guard virtualization-based security
                           * "DGCI" for Device Guard code integrity policy
    /boot                  reboot after applying policies
    /v                     verbose output
    /q                     quiet output (no headers)

To create a GPO backup from local policy:

    LGPO.exe /b path [/n GPO-name]

    /b path               Create GPO backup in "path"
    /n GPO-name           Optional GPO display name (use quotes if it contains spaces)

To parse a Registry.pol file to LGPO text (stdout):

    LGPO.exe /parse [/q] {/m|/u|/ua|/un|/u:username} path\registry.pol

    /m path\registry.pol   parse registry.pol as machine config commands
    /u path\registry.pol   parse registry.pol as user config commands
    /ua path\registry.pol  parse registry.pol as user config for Administrators
    /un path\registry.pol  parse registry.pol as user config for Non-Administrators
    /u:username path\registry.pol
                           parse registry.pol as user config for local user
                           specified by "username"
    /q                     quiet output (no headers)

To build a Registry.pol file from LGPO text:

    LGPO.exe /r path\lgpo.txt /w path\registry.pol [/v]

    /r path\lgpo.txt      Read input from LGPO text file
    /w path\registry.pol  Write new registry.pol file

(See the documentation for more information and examples.)
```
