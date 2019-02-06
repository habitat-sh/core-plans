Configuration NewFirewallRule
{
    Import-DscResource -Module xNetworking
    Node 'localhost' {
        xFirewall "sqlserver-{{pkg.name}}"
        {
            Name   = "sqlserver-{{pkg.name}}"
            DisplayName = "sqlserver-{{pkg.name}}"
            Action = "Allow"
            Direction = "InBound"
            LocalPort = ("{{cfg.port}}")
            Protocol = "TCP"
            Ensure = "Present"
            Enabled  = "True"
        }

        xFirewall "sqlserver-browser"
        {
            Name   = "sqlserver-browser"
            DisplayName = "sqlserver-browser"
            Action = "Allow"
            Direction = "InBound"
            LocalPort = ("1434")
            Protocol = "UDP"
            Ensure = "Present"
            Enabled  = "True"
        }
    }
}
