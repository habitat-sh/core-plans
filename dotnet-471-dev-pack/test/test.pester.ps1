param (
    [Parameter(Mandatory=$true)]
    [string]$PackageIdentifier = ""
)

Describe "The NETFXSDK installation of pkg_ident [$PackageIdentifier] when" {
    Context "is the SDK version 4.7" {
        $sdk_version="4.7"
        It "has the 'Program Files/Windows Kits/NETFXSDK/$sdk_version/Include/um' directory" {
            "c:/hab/pkgs/$PackageIdentifier/Program Files/Windows Kits/NETFXSDK/$sdk_version/Include/um" | Should -Exist
        }
        It "has the 'Program Files/Windows Kits/NETFXSDK/$sdk_version/Lib/um/x64' directory" {
            "c:/hab/pkgs/$PackageIdentifier/Program Files/Windows Kits/NETFXSDK/$sdk_version/Lib/um/x64" | Should -Exist
        }
        It "has the 'Program Files/Microsoft SDKs/Windows/v10.0A/bin/NETFX $sdk_version Tools/x64' directory" {
            "c:/hab/pkgs/$PackageIdentifier/Program Files/Microsoft SDKs/Windows/v10.0A/bin/NETFX $sdk_version Tools/x64" | Should -Exist
        }
    }

    $sdk_version=Split-Path (Split-Path $PackageIdentifier -Parent) -Leaf
    Context "is the SDK version $sdk_version" {
        
        It "has the 'Program Files/Windows Kits/NETFXSDK/$sdk_version/Include/um' directory" {
            "c:/hab/pkgs/$PackageIdentifier/Program Files/Windows Kits/NETFXSDK/$sdk_version/Include/um" | Should -Exist
        }
        It "has the 'Program Files/Windows Kits/NETFXSDK/$sdk_version/Lib/um/x64' directory" {
            "c:/hab/pkgs/$PackageIdentifier/Program Files/Windows Kits/NETFXSDK/$sdk_version/Lib/um/x64" | Should -Exist
        }
        It "has the 'Program Files/Microsoft SDKs/Windows/v10.0A/bin/NETFX $sdk_version Tools/x64' directory" {
            "c:/hab/pkgs/$PackageIdentifier/Program Files/Microsoft SDKs/Windows/v10.0A/bin/NETFX $sdk_version Tools/x64" | Should -Exist
        }
    }
}
