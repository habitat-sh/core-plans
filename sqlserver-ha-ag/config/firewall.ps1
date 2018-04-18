Configuration NewFirewallRule
{
    Import-DscResource -Module xNetworking
    Node 'localhost' {
        xFirewall "ag-endpoint"
        {
            Name   = "ag-endpoint"
            DisplayName = "ag-endpoint"
            Action = "Allow"
            Direction = "InBound"
            LocalPort = ("{{cfg.endpoint_port}}")
            Protocol = "TCP"
            Ensure = "Present"
            Enabled  = "True"
        }

        xFirewall "{{cfg.availability_group_name}}-ProbingPort"
        {
            Name   = "{{cfg.availability_group_name}}-ProbingPort"
            DisplayName = "{{cfg.availability_group_name}}-ProbingPort"
            Action = "Allow"
            Direction = "InBound"
            LocalPort = ("{{cfg.probe_port}}")
            Protocol = "TCP"
            Ensure = "Present"
            Enabled  = "True"
        }
    }
}
