# patching

This cookbook manages patching systems according to several policies; it's intended to be
driven through Policyfiles.

# Timing

```
default['patching']['timing'] = "manual", "hourly", "daily", "weekly"
```

Four patch timings are supported: manual, hourly, daily, and weekly.

Hourly, Daily, and Weekly all have similar behavior. If the system has not been patched
within the last hour, day, or week, then the system will patch itself.

The manual uses an additional attribute, `patchlevel`, which defaults to `1`. When run,
the system will see to check if the current value of `patchlevel` is larger than the last
known value (or if it has never been patched) - if it is, then the system will be patched.
This allows administrators to completely control patch timing through updating the associated
Policyfile.

# Repositories

Because a significant amount of control can be gained from attaching the system to particular
repositories, this cookbook also supports adding repostories for each system. It currently
only supports SLES.

To do this, you set the following:

```
default['patching']['sles']['repositories'] = {
  'packman' => {
    'baseurl' => 'http://packman.inode.at',
    'path' => '/suse/openSUSE_Leap_42.3',
    'gpgcheck' => false,
  }
}
```

Where the values and keys of the hash map 1:1 to the `zypper_repository` resource.

Test.
