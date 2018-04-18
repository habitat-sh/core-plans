Configuration EnableAlwaysOn
{
    Import-DscResource -ModuleName SqlServerDsc

    Node 'localhost' {
        SqlAlwaysOnService 'EnableAlwaysOn'
        {
            Ensure               = 'Present'
            InstanceName         = "{{bind.database.first.cfg.instance}}"
            ServerName           = $env:computername
        }
    }
}
