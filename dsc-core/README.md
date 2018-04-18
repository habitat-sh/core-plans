# dsc-core

The `dsc-core` plan applies Powershell DSC configurations on Powershell Core. Typically on Windows Powershell, one uses `Start-DscConfiguration` to apply a compiled DSC configuration mof. However, Powershell Core does not expose the `Start-DscConfiguration` cmdlet. It is possible to call a WMI method to invoke the Local Configuration manager but it incurs a bit of ceremony since it expects the `ConfigurationData` as a byte stream. this plan encapsulates the compilation and execution of a configuration into a simple "one liner."

The plan puts its `psd1` and `psm1` files in the `PSModulePath` so that its function `Start-DscCore` is automatically discoverable.

## Maintainers

The Habitat Maintainers humans@habitat.sh


## Type of Package

A Binary package containing a Powershell Module

## Usage

Note: This package can only be used if the Habitat Supervisor node has [WMF 5](https://www.microsoft.com/en-us/download/details.aspx?id=50395) installed. Otherwise, the DSC invocations will fail.

Assuming you have the following configuration in a file `firewall.ps1` in your plan's `config` directory:

```
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

```
Start-DscCore (Join-Path {{pkg.svc_config_path}} firewall.ps1) NewFirewallRule
```

Note that the above configuration imports `xNetworking`. You will need to ensure that this module is installed prior to calling `Start-DscCore`. Because the configuration is applied by the Local Configuration Manager, it is not run inside of the current Powershell Core session but is run inside of a Windows Powershell session. Therefore you must install the `xNetworking` module inside of Windows Powershell. The easiest way to do this is to "remote" to a local `PSSession` and then run the install.

```
Invoke-Command -ComputerName localhost -EnableNetworkAccess {
    if(!(Get-Module xNetworking -ListAvailable)) {
        Install-Module xNetworking -Force | Out-Null
    }
}
```

### Problems using in a local Windows Studio

The `PSModulePath` in a local Windows studio (one started with `hab studio enter -w`) will get assigned the wrong package path and thus simply calling `Start-DscCore` will not automatically import this module.

You can work around this by explicitly importing the module before using the command:

```
Import-Module "{{pkgPathFor "core/dsc-core"}}/Modules/DscCore"
Start-DscCore (Join-Path {{pkg.svc_config_path}} firewall.ps1) NewFirewallRule
```
