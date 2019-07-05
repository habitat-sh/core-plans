# dsc-core

The `dsc-core` plan applies Powershell DSC configurations on Powershell Core. Typically on Windows Powershell, one uses `Start-DscConfiguration` to apply a compiled DSC configuration mof. However, Powershell Core does not expose the `Start-DscConfiguration` cmdlet. It is possible to call a WMI method to invoke the Local Configuration manager but it incurs a bit of ceremony since it expects the `ConfigurationData` as a byte stream. This plan encapsulates the compilation and execution of a configuration into a simple "one liner."

Note that this plan takes a dependency on the `core/ps-lock` plan to ensure that calls to apply a DSC configuration are serialized. See the [DSC and LCM Concurrency Protection](#DSC-and-LCM-Concurrency-Protection) section for more details.

The plan puts its `psd1` and `psm1` files in the `PSModulePath` so that its function `Start-DscCore` is automatically discoverable.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

A Binary package containing a Powershell Module

## Usage

Note: This package can only be used if the Habitat Supervisor node has [WMF 5](https://www.microsoft.com/en-us/download/details.aspx?id=50395) installed. Otherwise, the DSC invocations will fail.

### xNetworking Example

Assuming you have the following configuration in a file `firewall.ps1` in your plan's `config` directory:

```PowerShell
Configuration NewFirewallRule
{
    Import-DscResource -Module xNetworking
    Node 'localhost' {
        xFirewall "ag-endpoint"
        {
            Name   = "ag-endpoint"
            DisplayName = "ag-endpoint"
            Action = "Allow"
            Direction = "InBound"
            LocalPort = ("{{cfg.endpoint_port}}")
            Protocol = "TCP"
            Ensure = "Present"
            Enabled  = "True"
        }
    }
}
```

Your `hook` can apply this configuration using:

```PowerShell
Start-DscCore (Join-Path {{pkg.svc_config_path}} firewall.ps1) NewFirewallRule
```

Note that the above configuration imports `xNetworking`. You will need to ensure that this module is installed prior to calling `Start-DscCore`. Because the configuration is applied by the Local Configuration Manager, it is not run inside of the current Powershell Core session but is run inside of a Windows Powershell session. Therefore you must install the `xNetworking` module inside of Windows Powershell. The easiest way to do this is to "remote" to a local `PSSession` and then run the install.

```PowerShell
Invoke-Command -ComputerName localhost -EnableNetworkAccess {
    if(!(Get-Module xNetworking -ListAvailable)) {
        Install-Module xNetworking -Force | Out-Null
    }
}
```

### ComputerManagementDsc Example

Assuming you have the following configuration in a file `task.ps1` and `script.ps1` in your plan's `config` directory and you want to create a scheduled task that runs every 15 minutes with credentials stored in TOML:

```PowerShell
Configuration NewTask
{
  param(
  )

  Import-DscResource -ModuleName PSDesiredStateConfiguration
  Import-DscResource -ModuleName ComputerManagementDsc -ModuleVersion 6.4.0.0
  Node 'localhost' {
   write-warning "$($node.Password|out-string)"
    $username = $node.Username
    $password = ConvertTo-SecureString $node.Password -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

    ScheduledTask Task1 {
        TaskName            = 'Sample Task'
        TaskPath            = '\SampleTasks'
        ActionExecutable    = 'C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe'
        ActionArguments     = "-File `"$($node.scriptDestination)`""
        ActionWorkingPath   = (split-path $node.scriptDestination -parent)
        ScheduleType        = 'Daily'
        DaysInterval        = 1
        RepeatInterval      = '00:15:00'
        RepetitionDuration  = 'Indefinitely'
        ExecuteAsCredential = $Credential
      }
  }
}
```

Your `hook` can apply this configuration using:

```PowerShell
$cd = @{
        AllNodes = @(
            @{
                NodeName                    = 'localhost'
                PSDscAllowPlainTextPassword = $true # Allows a credential in the DSC config (mof file is deleted after config)
                Username                    = '{{cfg.task_user}}'
                Password                    = '{{cfg.task_pass}}'
                scriptDestination           = "$((Join-Path '{{pkg.svc_config_path}}' script.ps1))"
                RepeatInterval              = '00:15:00'
            }
        )
    }
Start-DscCore (Join-Path {{pkg.svc_config_path}} task.ps1) NewTask $cd
```

### DSC and LCM Concurrency Protection

The DSC engine (LCM) can only apply a single configuration at a time on a machine. This plan uses the `core/ps-lock` plan to ensure that all `SendConfigurationApply` calls to the LCM are serialized and avoid potential exceptions from the LCM stating it is already applying a configuration.

This should be completely transparent to consumers of this plan. However, if there is a service running on the same Supervisor that runs a `chef-client` that converges `dsc_resource` or `dsc_script` resources, those resources could potentially fail if `Start-DscCore` is performing an apply. You can avoid these potential errors by having the `chef-client` run honor the lock used by `Start-DscResource`. Declare a `$pkg_deps` on `core/ps-lock` and `core/dsc-core` and call the `chef-client` similar to the following:

```PowerShell
Enter-PSLock -Name $(Get-DscLock) -Interval 10 -Splay 10 {
    {{pkgPathFor "core/chef-dk"}}\chefdk\bin\chef-client -z
}
```

If the `chef-client` only needs to run once, you can ommit the `-Interval` and `-Splay` arguments.

### Problems using in a local Windows Studio

The `PSModulePath` in a local Windows studio (one started with `hab studio enter -w`) will get assigned the wrong package path and thus simply calling `Start-DscCore` will not automatically import this module.

You can work around this by explicitly importing the module before using the command:

```PowerShell
Import-Module "{{pkgPathFor "core/dsc-core"}}/Modules/DscCore"
Start-DscCore (Join-Path {{pkg.svc_config_path}} firewall.ps1) NewFirewallRule
```

# Testing

```
hab pkg build dsc-core
. .\results\last_build.ps1
hab studio run -D "hab pkg install results/$pkg_artifact;& dsc-core/tests/test.ps1 $pkg_ident"
```
