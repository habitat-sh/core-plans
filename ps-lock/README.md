# ps-lock

The `ps-lock` plan provides a way to sychronize scripts run from Habitat hooks so that Supervisor threads running these scripts will be serialized to one call at a time. One example where this maybe useful is if multiple services on a single Supervisor need to install an `MSI` file. If two `run` hooks execute the `msi` install at the same time, one will fail because only one `MSIEXEC` instance can run on the os at a time. This plan exposes a `Enter-PSLock` function that takes a lock name and a `ScriptBlock` which will not be simultaneously with any other block run under the same lock name.

The plan puts its `psd1` and `psm1` files in the `PSModulePath` so that its function `Start-DscCore` is automatically discoverable.

## Maintainers

The Habitat Maintainers humans@habitat.sh


## Type of Package

A Binary package containing a Powershell Module

## Usage

### Locking Hook Execution with a Named Lock

You may have multiple services that Install an MSI. You can ensure that all MSI actions are serialized to one operation at a time with:

```
Enter-PSLock -Name MSILock {
    Start-Process mymsi.msi -wait -ArgumentList "/S"
}
```

Any hook that calls `Enter-PSLock` with a lock named `MSILock` will block as it waits its turn to run its `ScriptBlock`.

### Using the Default Lock

If you do not provide a `-Name` argument, the `ScriptBlock` will run under the default lock `_hab_pslock_default`.

### Using Interval and Splay with `Enter-PSLock`

It's possible that your `run` hook may need to run a script in a continuous loop at a specific interval. When it is time for your script to run, you want it to wait and hold the lock and then release the lock before waiting for the next interval. An example use case here is if your hook call `chef-client` which may have cookbooks that converge resources that can not be run concurrently on a single Supervisor.

You can provide `-Interval` and `-Splay` arguments to `Enter-PSLock` which will run the `ScriptBlock` continuously and wait before calling the block again. The time to wait will be the number of seconds in the `Interval` plus a random number of seconds between `0` and `Splay`.

```
Enter-PSLock -Name MSILock -Interval 1800 -Splay 30 {
    Start-Process "{{pkgPathFor "core/chef-dk"}}\chefdk\bin\chef-client.bat" -ArgumentList "-z" -Wait -NoNewWindow
}
```

### Problems using in a local Windows Studio

The `PSModulePath` in a local Windows studio (one started with `hab studio enter -w`) will get assigned the wrong package path and thus simply calling `Enter-PSLock` will not automatically import this module.

You can work around this by explicitly importing the module before using the command:

```
Import-Module "{{pkgPathFor "core/ps-lock"}}/Modules/PSLock"
Enter-PSLock { <SOME_POWERSHELL_CODE>}
```
