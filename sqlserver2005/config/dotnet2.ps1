$source = "{{cfg.netfx3_source}}"
Configuration DotNet
{
    Node 'localhost' {
        if($source -eq "") {
            WindowsFeature dotnet2 {
                Ensure = "Present"
                Name   = "NET-Framework-Features"
            }
        } else {
            WindowsFeature dotnet2 {
                Ensure = "Present"
                Name   = "NET-Framework-Features"
                Source = $source
            }
        }
    }
}
