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

    # We disable progress stream output since that tends to mangle the
    # Supervisor output
    $currentProgPref = $global:ProgressPreference
    $global:ProgressPreference = "SilentlyContinue"

    Write-Output "Compiling DSC mof for $ConfigFunction ..."

    # Because the DSC configuration will be applied by the Local Configuration
    # Manager in the context of a Windows Powershell session (not the same
    # Powershell Core session of the hook), we want to compile the configuration
    # in that same context. This is mainly som that Powershell Modules imported
    # are discovered from the same PSModulePath. To do this we compile the mof
    # in a local Windows Powershell session.
    $mof = Invoke-Command -ComputerName localhost -EnableNetworkAccess -ArgumentList $Path, $ConfigFunction {
        param ($confPath, $func)
        $global:WarningPreference = "SilentlyContinue"
        . $confPath
        $tempDir = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
        New-Item -ItemType Directory -Path $tempDir | Out-Null
        & $func -OutputPath $tempDir
    }

    $configurationData = Get-Content $mof.FullName -AsByteStream -ReadCount 0
    $totalSize = [System.BitConverter]::GetBytes($configurationData.Length + 4)
    $configurationData = $totalSize + $configurationData

    Write-Output "Applying DSC configuration for $Path ..."
    Invoke-CimMethod    -ComputerName localhost `
                        -Namespace "root/Microsoft/Windows/DesiredStateConfiguration" `
                        -ClassName "MSFT_DSCLocalConfigurationManager" `
                        -MethodName "SendConfigurationApply" `
                        -Arguments @{ConfigurationData = $configurationData; Force = $true} `
                        -ErrorAction Stop | Out-Null

    $global:ProgressPreference = $currentProgPref
    Remove-Item $mof.Directory -Recurse -Force | Out-Null
}
