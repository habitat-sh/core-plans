param (
    [Parameter()]
    [string]$PackageIdentifier = $(throw "Fully qualified package identifier must be given as a parameter.")
)

Import-Module "$(hab pkg path $PackageIdentifier)\Modules\DscCore" -force

InModuleScope -ModuleName DSCCore {
    Describe "Simple Functions" -tag Unit {
        Mock Start-Sleep {}
        Mock Get-LcmMetaConfig {
            @{
                LCMState = 'Idle'
            }
        }
        Context 'Wait-LCMReady' {
            It 'Runs with no errors' {
                Wait-LCMReady
                $? | Should be $true
            }
        }
        Context 'Get-LcmMetaConfig' {
            It 'Runs with no errors' {
                Get-LcmMetaConfig
                $? | Should be $true
            }
        }
        Context 'Set-LcmMetaConfig' {
            Mock Invoke-CimMethod {}
            It 'Runs with no errors' {
                Set-LcmMetaConfig (New-Object Byte[] 100)
                $? | Should be $true
            }
        }
        Context 'Set-LcmRefreshMode' {
            Mock Invoke-CimMethod {}
            Mock New-ConfigurationData {}
            Mock Set-LcmMetaConfig {}
            It 'Runs with no errors' {
                Set-LcmRefreshMode Push
                $? | Should be $true
            }
        }
    }
    Describe "Start-DscCore" -tag Unit {
        Mock Enter-PSLock {Invoke-Command -ScriptBlock $ScriptBlock}
        Mock Enter-QuietProgress {Invoke-Command -ScriptBlock $block}
        Mock Wait-LCMReady {}
        Mock Set-LcmRefreshMode {}
        Mock Invoke-CimMethod {}
        Context "test_without_resource" {
            Mock New-ConfigurationData {}
            Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_without_resource
            It "doesn't enter PS Lock" {
                Assert-MockCalled Enter-PSLock -Times 0
            }
        }
        Context "test_with_resource" {
            Mock New-ConfigurationData {New-Object Byte[] 100}
            Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_with_resource
            It "enters PS Lock" {
                Assert-MockCalled Enter-PSLock -Times 1
            }
        }
    }
    Describe "New-ConfigurationData" -tag Unit {
        Mock Enter-PSLock -ModuleName DSCCore {Invoke-Command -ScriptBlock $ScriptBlock}
        Mock Enter-QuietProgress -ModuleName DSCCore {Invoke-Command -ScriptBlock $block}
        Mock Wait-LCMReady -ModuleName DSCCore {}
        Mock Set-LcmRefreshMode -ModuleName DSCCore {}

        Context "no mof file generated" {
            Mock Remove-Item {}
            Mock Get-Content {}
            Mock Invoke-Command {}
            New-ConfigurationData -configuration c:\temp\fake_dsc_file.ps1 -ConfigFunction test_without_resource
            It "doesn't try to read mof" {
                Assert-MockCalled Get-Content -Times 0
            }
            It "doesn't try to remove mof" {
                Assert-MockCalled Remove-Item -Times 0
            }
        }
        Context "mof file generated" {
            Mock Remove-Item {}
            Mock Invoke-Command {
                @{
                    FullName  = 'c:\temp\fake.mof'
                    Directory = 'c:\temp'
                }
            }
            Mock Get-Content {New-Object Byte[] 100}
            New-ConfigurationData -configuration c:\temp\fake_dsc_file.ps1 -ConfigFunction test_without_resource
            It "should read mof" {
                Assert-MockCalled Get-Content -Times 1
            }
            It "should remove mof folder" {
                Assert-MockCalled Remove-Item -Times 1
            }
        }
    }
    Describe "Invoke-DSCCommandFile" -tag Unit {
        Context "no config data passed" {
            Mock ConvertTo-Json {}
            Mock ConvertFrom-Json {}
            $results = Invoke-DSCCommandFile -config "function test_dsc_function (`$OutputPath){@{FullName  = 'c:\temp\fake.mof';Directory = `$OutputPath}}" -func test_dsc_function
            # Clean up temp folder
            Remove-Item $results.directory -Recurse
            It "doesn't format config data" {
                Assert-MockCalled ConvertTo-Json -Times 0
            }
        }
        Context "config data passed" {
            # AllNodes is changed from type 'Object[]' to 'ArrayList' went sent through invoke-command
            $cd = Invoke-Command -EnableNetworkAccess -computername localhost {
                @{
                    AllNodes = @(
                        @{
                            NodeName                    = 'localhost'
                            PSDscAllowPlainTextPassword = $true # This is required so DSC allows a password in the config (mof file is deleted right after config)
                        }
                    )
                }
            }

            $results = Invoke-DSCCommandFile -config "function test_dsc_function (`$OutputPath, `$ConfigurationData){@{Directory = `$OutputPath;ConfigurationData = `$ConfigurationData}}" -func test_dsc_function -ConfigData $cd
            Remove-Item $results.directory -Recurse
            It "should have initial configuration data of type ArrayList" {
                $cd.AllNodes -is [System.Collections.ArrayList] | should be $true
            }

            It "should convert ConfigData to an object array that works with DSC" {
                $results.ConfigurationData.AllNodes -is [PSObject[]] | should be $true
            }
        }
    }
}

Describe "dsc-core" -tag Functional {
    Context "Apply Configuration with file resource" {
        It "creates the directory" {
            Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_with_resource
            "c:\test_directory" | Should exist
            $? | Should be $true
        }
    }
    Context "Apply Configuration without resource" {
        It "runs without error" {
            Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_without_resource
            $? | Should be $true
        }
    }
    Context "Apply configuration with resource and configuration data" {
        It "runs without error" {
            $cd = @{
                AllNodes = @(
                    @{
                        NodeName                    = 'localhost'
                        PSDscAllowPlainTextPassword = $true # This is required so DSC allows a password in the config (mof file is deleted right after config)
                        Password                    = 'vagrant'
                        Username                    = 'vagrant'
                        DestinationPath             = 'C:\test_directory1'
                    }
                )
            }
            Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_with_resource_config_data $cd
            $? | Should be $true
        }
        It "Creates the test folder" {
            "c:\test_directory1" | Should exist
        }
        It "throws error when missing required field 'PSDscAllowPlainTextPassword' in config" {
            $cd = @{
                AllNodes = @(
                    @{
                        NodeName        = 'localhost'
                        # PSDscAllowPlainTextPassword = $true # This is required so DSC allows a password in the config (mof file is deleted right after config)
                        Password        = 'vagrant'
                        Username        = 'vagrant'
                        DestinationPath = 'C:\test_directory1'
                    }
                )
            }
            {Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_with_resource_config_data $cd -erroraction stop}|Should throw "'Credential' OF TYPE 'File'"
        }
    }
    Context "Apply Configuration to cleanup" {
        It "runs without error" {
            Start-DscCore (Join-Path $PSScriptRoot test_config.ps1) test_cleanup
            $? | Should be $true
        }
    }
}
