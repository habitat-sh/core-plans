Configuration DotNet
{
    Node 'localhost' {
        WindowsFeature dotnet2
        {
            Ensure = "Present"
            Name = "NET-Framework-Features"
            {{#if cfg.netfx3_source}}
                Source = "{{cfg.netfx3_source}}"
            {{/if}}
        }
    }
}
