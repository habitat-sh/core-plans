# dsc-core

The `dsc-core` plan applies Powershell DSC configurations on Powershell Core. Typically on Windows Powershell, one uses `Start-DscConfiguration` to apply a compiled DSC configuration mof. However, Powershell Core does not expose the `Start-DscConfiguration` cmdlet. It is possible to call a WMI method to invoke the Local Configuration manager but it incurs a bit of ceremony since it expects the `ConfigurationData` as a byte stream. this plan encapsulates the compilation and execution of a configuration into a simple "one liner."

Note that this plan takes a dependency on the `core/ps-lock` plan to ensure that calls to apply a DSC configuration are serialized. See the [DSC and LCM Concurrency Protection](#DSC-and-LCM-Concurrency-Protection) section for more details.

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

### DSC and LCM Concurrency Protection

The DSC engine (LCM) can only apply a single configuration at a time on a machine. This plan uses the `core/ps-lock` plan to ensure that all `SendConfigurationApply` calls to the LCM are serialized and avoid potential exceptions from the LCM stating it is already applying a configuration.

This should be completely transparent to consumers of this plan. However, if there is a service running on the same Supervisor that runs a `chef-client` that converges `dsc_resource` or `dsc_script` resources, those resources could potentially fail if `Start-DscCore` is performing an apply. You can avoid these potential errors by having the `chef-client` run honor the lock used by `Start-DscResource`. Declare a `$pkg_deps` on `core/ps-lock` and `core/dsc-core` and call the `chef-client` similar to the following:

```
Enter-PSLock -Name $(Get-DscLock) -Interval 10 -Splay 10 {
    {{pkgPathFor "core/chef-dk"}}\chefdk\bin\chef-client -z
}
```

If the `chef-client` only needs to run once, you can ommit the `-Interval` and `-Splay` arguments.

### Problems using in a local Windows Studio

The `PSModulePath` in a local Windows studio (one started with `hab studio enter -w`) will get assigned the wrong package path and thus simply calling `Start-DscCore` will not automatically import this module.

You can work around this by explicitly importing the module before using the command:

```
Import-Module "{{pkgPathFor "core/dsc-core"}}/Modules/DscCore"
Start-DscCore (Join-Path {{pkg.svc_config_path}} firewall.ps1) NewFirewallRule
```
