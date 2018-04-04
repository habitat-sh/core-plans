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
    }
}
