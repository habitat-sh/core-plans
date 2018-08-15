Import-Module "$PSScriptRoot\PSLock.psd1"

<#
    .SYNOPSIS
        Returns the Lock Name used to synchronize DSC calls
#>
function Get-DscLock {
    [CmdletBinding()]
    param()
    "_hab_dsc_core"
}

<#
    .SYNOPSIS
        Applies a DSC configuration on Powershell Core
    .PARAMETER Path
        The path to the file containing the DSC configuration
    .PARAMETER ConfigFunction
        The function name of the configuration
#>
function Start-DscCore {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Path,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ConfigFunction
    )

    Enter-QuietProgress {
        Write-Output "Compiling DSC mof for $ConfigFunction ..."

        $configurationData = New-ConfigurationData (Get-Content $Path | Out-String) $ConfigFunction

        while((Get-LcmMetaConfig).LCMState -ne "Idle") {
            Write-Host "Waiting for LCM to become Idle..."
            Start-Sleep -Seconds 5
        }

        Enter-PSLock -Name $(Get-DscLock) {
            $conf = Get-LcmMetaConfig
            $currentRefreshMode = $conf.RefreshMode
            try {
                Set-LcmRefreshMode "Push"
                Write-Output "Applying DSC configuration for $Path ..."
                Invoke-CimMethod    -ComputerName localhost `
                                    -Namespace "root/Microsoft/Windows/DesiredStateConfiguration" `
                                    -ClassName "MSFT_DSCLocalConfigurationManager" `
                                    -MethodName "SendConfigurationApply" `
                                    -Arguments @{ConfigurationData = $configurationData} `
                                    -ErrorAction Stop | Out-Null
            }
            finally {
                Set-LcmRefreshMode $currentRefreshMode
            }
        }
    }
}

function New-ConfigurationData($configuration, $ConfigFunction) {
    # Because the DSC configuration will be applied by the Local Configuration
    # Manager in the context of a Windows Powershell session (not the same
    # Powershell Core session of the hook), we want to compile the configuration
    # in that same context. This is mainly so that Powershell Modules imported
    # are discovered from the same PSModulePath. To do this we compile the mof
    # in a local Windows Powershell session.
    try {
        $mof = Invoke-Command -ComputerName localhost -EnableNetworkAccess -ArgumentList $configuration, $ConfigFunction {
            param ($config, $func)
            $global:WarningPreference = "SilentlyContinue"
            Invoke-Expression $config
            $tempDir = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
            New-Item -ItemType Directory -Path $tempDir | Out-Null
            & $func -OutputPath $tempDir
        }

        $configurationData = Get-Content $mof.FullName -AsByteStream -ReadCount 0
    }
    finally {
        if($mof) { Remove-Item $mof.Directory -Recurse -Force | Out-Null }
    }

    $totalSize = [System.BitConverter]::GetBytes($configurationData.Length + 4)
    $totalSize + $configurationData
}

function Enter-QuietProgress([ScriptBlock]$block) {
    # We disable progress stream output since that tends to mangle the
    # Supervisor output
    $currentProgPref = $global:ProgressPreference
    $global:ProgressPreference = "SilentlyContinue"

    try {
        Invoke-Command -ScriptBlock $block
    }
    finally {
        $global:ProgressPreference = $currentProgPref
    }
}

function Get-LcmMetaConfig {
    Enter-QuietProgress {
        $lcm = Invoke-CimMethod -ComputerName localhost `
                                -Namespace "root/Microsoft/Windows/DesiredStateConfiguration" `
                                -ClassName "MSFT_DSCLocalConfigurationManager" `
                                -MethodName "GetMetaConfiguration"
        $lcm.MetaConfiguration
    }
}

function Set-LcmMetaConfig($configData) {
    Enter-QuietProgress {
        Invoke-CimMethod -ComputerName localhost `
                         -Namespace "root/Microsoft/Windows/DesiredStateConfiguration" `
                         -ClassName "MSFT_DSCLocalConfigurationManager" `
                         -MethodName "SendMetaConfigurationApply" `
                         -Arguments @{ConfigurationData = $configData} `
                         -ErrorAction Stop | Out-Null
    }
}

function Set-LcmRefreshMode($mode) {
    $conf = @"
    [DSCLocalConfigurationManager()]
    configuration LCMConfig
    {
        Node localhost
        {
            Settings
            {
                RefreshMode = "$mode"
            }
        }
    }
"@

    $configurationData = New-ConfigurationData $conf LCMConfig
    Set-LcmMetaConfig $configurationData
}
