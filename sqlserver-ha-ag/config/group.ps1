$secondary = @()
$primary = '{{bind.database.first.sys.hostname}}'
$instance="{{bind.database.first.cfg.instance}}"
{{~#eachAlive bind.database.members as |member|}}
if($primary -ne '{{member.sys.hostname}}') {
    $secondary += '{{member.sys.hostname}}'
}
{{~/eachAlive}}

Configuration NewAvailabilityGroup
{
    Import-DscResource -ModuleName SqlServerDsc
    Node 'localhost' {
        SqlServerEndpoint 'AddEndpoint'
        {
            EndpointName         = "HADR-${env:computername}"
            InstanceName         = $instance
            ServerName           = $env:computername
            Port                 = '{{cfg.endpoint_port}}'
        }

        SqlAG 'AddAG'
        {
            Ensure               = 'Present'
            Name                 = '{{cfg.availability_group_name}}'
            InstanceName         = $instance
            ServerName           = $env:computername
            FailoverMode         = "{{cfg.failover_mode}}"
            AvailabilityMode     = "{{cfg.availability_mode}}"
        }

        foreach($s in $secondary) {

            SqlServerEndpoint "AddEndpoint-$s"
            {
                EndpointName         = "HADR-$s"
                InstanceName         = $instance
                ServerName           = $s
                Port                 = '{{cfg.endpoint_port}}'
            }

            SqlAGReplica "AddReplica-$s"
            {
                Ensure                     = 'Present'
                Name                       = "$s\$instance"
                AvailabilityGroupName      = '{{cfg.availability_group_name}}'
                ServerName                 = $s
                InstanceName               = $instance
                PrimaryReplicaServerName   = $env:computername
                PrimaryReplicaInstanceName = $instance
                FailoverMode               = "{{cfg.failover_mode}}"
                AvailabilityMode           = "{{cfg.availability_mode}}"
            }
        }

        if("{{cfg.databases}}" -ne "''" -and ($secondary.Count -gt 0)) {
            SqlAGDatabase 'AddDatabase'
            {
                AvailabilityGroupName   = '{{cfg.availability_group_name}}'
                BackupPath              = "{{cfg.backup_path}}"
                DatabaseName            = {{cfg.databases}}
                InstanceName            = $instance
                ServerName              = $env:computername
                Ensure                  = 'Present'
                ProcessOnlyOnActiveNode = $false
            }
        }

        if('{{cfg.availability_group_ip}}' -ne '') {
            SqlAGListener 'AddListener'
            {
                Ensure               = 'Present'
                ServerName           = $env:computername
                InstanceName         = $instance
                AvailabilityGroup    = '{{cfg.availability_group_name}}'
                Name                 = '{{cfg.availability_group_name}}'
                IpAddress            = '{{cfg.availability_group_ip}}/255.255.255.0'
                Port                 = {{bind.database.first.cfg.port}}
            }
        }
    }
}
