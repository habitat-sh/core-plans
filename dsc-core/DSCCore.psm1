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
    .PARAMETER ConfigData
        Hashtable used to define data that can be used within a
        configuration allowing for the creation of a single configuration
        that can be used for multiple nodes or for different environments
    .EXAMPLE
        Start-DscCore c:\temp\firewall.ps1 NewFirewallRule
    .EXAMPLE
        $cd = @{
            AllNodes = @(
                @{
                    NodeName                    = 'localhost'
                    PSDscAllowPlainTextPassword = $true
                    Username                    = 'vagrant'
                    Password                    = 'vagrant'
                    scriptDestination           = "script.ps1"
                    RepeatInterval              = '00:15:00'
                }
            )
        }
        Start-DscCore c:\temp\tasks.ps1 NewTask $cd
#>
function Start-DscCore {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Path,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ConfigFunction,

        [Parameter(Mandatory = $false)]
        [Hashtable]
        $ConfigData
    )

    Enter-QuietProgress {
        Write-Output "Compiling DSC mof for $ConfigFunction ..."

        $configurationData = New-ConfigurationData (Get-Content $Path | Out-String) $ConfigFunction $ConfigData

        if ($configurationData) {
            Wait-LCMReady

            Enter-PSLock -Name $(Get-DscLock) {
                $conf = Get-LcmMetaConfig
                $currentRefreshMode = $conf.RefreshMode
                try {
                    # Now that we have the lock, check once more just in case
                    Wait-LCMReady
                    Set-LcmRefreshMode "Push"
                    Write-Output "Applying DSC configuration for '$ConfigFunction' in $Path ..."
                    Invoke-CimMethod    -ComputerName localhost `
                        -Namespace "root/Microsoft/Windows/DesiredStateConfiguration" `
                        -ClassName "MSFT_DSCLocalConfigurationManager" `
                        -MethodName "SendConfigurationApply" `
                        -Arguments @{ConfigurationData = $configurationData; Force = $true} `
                        -ErrorAction Stop | Out-Null
                } finally {
                    Wait-LCMReady
                    Set-LcmRefreshMode $currentRefreshMode
                }
            }
        } else {
            Write-Warning "No MOF was generated from configuration. Perhaps your configuration does not include resources."
        }
    }
}

function Wait-LCMReady {
    while ((Get-LcmMetaConfig).LCMState -eq "Busy") {
        Write-Host "Waiting for LCM to become available. Current state: $((Get-LcmMetaConfig).LCMState)..."
        Start-Sleep -Seconds 5
    }
}

function Invoke-DscCommandFile {
    # Function is ment to be sent via Invoke-Command to run in Powershell 5
    param ($config, $func, $ConfigData)

    $global:WarningPreference = "SilentlyContinue"

    function ConvertPSObjectToHashtable {
        param (
            [Parameter(ValueFromPipeline)]
            $InputObject
        )

        process {
            if ($null -eq $InputObject) { return $null }

            if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
                $collection = @(
                    foreach ($object in $InputObject) { ConvertPSObjectToHashtable $object }
                )

                Write-Output -NoEnumerate $collection
            } elseif ($InputObject -is [psobject]) {
                $hash = @{}

                foreach ($property in $InputObject.PSObject.Properties) {
                    $hash[$property.Name] = ConvertPSObjectToHashtable $property.Value
                }

                $hash
            } else {
                $InputObject
            }
        }
    }
    $tempDir = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
    $dscParam = @{OutputPath = $tempDir}

    # $ConfigData has been changed by Invoke-Command and will throw an error when
    # we invoke DSC unless we recursively convert it back to a PowerShell hashtable
    if ($ConfigData) {
        # Simple trick to make $ConfigData a native PowerShell Object
        $object = $ConfigData | ConvertTo-Json -Depth 6 | ConvertFrom-Json
        $psd1 = ConvertPSObjectToHashtable $object
        $dscParam.add('ConfigurationData', $psd1)
    }

    New-Item -ItemType Directory -Path $tempDir | Out-Null
    $dscPath = Join-Path $tempDir dsc.ps1
    $config | Out-File $dscPath

    # Run DSC configuration from temp folder
    try {
        . $dscPath
    }
    catch {
        Remove-Item $tempDir -Recurse
        throw "Problems running DSC configuration file containing '$func': $($_.exception.message -replace [regex]::Escape($dscPath), '')"
    }
    # Create Mof file in temp folder
    & $func.trim() @dscParam
}

function New-ConfigurationData($configuration, $ConfigFunction, $ConfigData) {
    # Because the DSC configuration will be applied by the Local Configuration
    # Manager in the context of a Windows Powershell session (not the same
    # Powershell Core session of the hook), we want to compile the configuration
    # in that same context. This is mainly so that Powershell Modules imported
    # are discovered from the same PSModulePath. To do this we compile the mof
    # in a local Windows Powershell session.
    try {
        $mof = Invoke-Command -ComputerName localhost -EnableNetworkAccess -ArgumentList $configuration, $ConfigFunction, $ConfigData ${function:Invoke-DSCCommandFile}
        if ($mof) {
            $configurationData = Get-Content $mof.FullName -AsByteStream -ReadCount 0
            $totalSize = [System.BitConverter]::GetBytes($configurationData.Length + 4)
            $totalSize + $configurationData
        }
    } finally {
        if ($mof) { Remove-Item $mof.Directory -Recurse -Force | Out-Null }
    }
}

function Enter-QuietProgress([ScriptBlock]$block) {
    # We disable progress stream output since that tends to mangle the
    # Supervisor output
    $currentProgPref = $global:ProgressPreference
    $global:ProgressPreference = "SilentlyContinue"

    try {
        Invoke-Command -ScriptBlock $block
    } finally {
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
