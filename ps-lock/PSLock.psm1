<#
    .SYNOPSIS
        Provides a way to sychronize scripts run from Habitat hooks so that
        Supervisor threads running these scripts will be serialized to one
        call at a time

    .PARAMETER ScriptBlock
        The script to synchronize

    .PARAMETER Name
        The name to give to the lock. If not provided, the default lock
        name of _hab_pslock_default will be used

    .PARAMETER Interval
        The number of seconds to pause before running the block again. The
        block will only be run once if no Interval or Splay are provided

    .PARAMETER Splay
        The maximum random number to add to Interval

    .EXAMPLE
        Using a lock named 'MSILock' will block as it waits its turn to run
        its ScriptBlock

        Enter-PSLock -Name MSILock {
            Start-Process mymsi.msi -wait -ArgumentList "/S"
        }

    .EXAMPLE
        Using no lock name will use the default '_hab_pslock_default' lock

        Enter-PSLock { Start-Process my.exe -wait }

    .EXAMPLE
        Providing `-Interval` and `-Splay` arguments will run the `ScriptBlock`
        continuously and wait before calling the block again.
        The time to wait will be the number of seconds in the `Interval` plus a
        random number of seconds between `0` and `Splay`

        Enter-PSLock -Name MSILock -Interval 1800 -Splay 30 {
            Start-Process "{{pkgPathFor "core/chef-dk"}}\chefdk\bin\chef-client.bat" -ArgumentList "-z" -Wait -NoNewWindow
        }

#>
function Enter-PSLock {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock,

        [Parameter(Mandatory = $false)]
        [System.String]
        $Name = "_hab_pslock_default",

        [Parameter(Mandatory = $false)]
        [int]
        $Interval,

        [Parameter(Mandatory = $false)]
        [int]
        $Splay
    )
    if(($Interval + $Splay) -eq 0) {
        Enter-InternalPSLock $ScriptBlock $Name
    }
    else {
        $Interval = $Interval + (Get-Random -Maximum $Splay)
        while($true) {
            Enter-InternalPSLock $ScriptBlock $Name
            Write-Host "Sleeping for $Interval seconds before attempting $Name lock"
            Start-Sleep -Seconds $Interval
        }
    }
}

function Enter-InternalPSLock($block, $name) {
    $lock = [System.Threading.Mutex]::new($false, $name)

    try {
        Write-Host "Waiting for $name lock..."
        $lock.WaitOne() | Out-Null
        Write-Host "Obtained lock for $name"
        Invoke-Command -ScriptBlock $block
    }
    finally {
        $lock.ReleaseMutex()
        Write-Host "Released lock for $name"
        $lock.Dispose()
    }
}
