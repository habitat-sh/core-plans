Configuration EnableFailover
{
    Node 'localhost' {
        WindowsFeature FailoverFeature
        {
            Ensure = "Present"
            Name      = "Failover-clustering"
        }

        WindowsFeature RSATClusteringManagement
        {
            Ensure = "Present"
            Name   = "RSAT-Clustering-Mgmt"
        }

        WindowsFeature RSATClusteringPowerShell
        {
            Ensure = "Present"
            Name   = "RSAT-Clustering-PowerShell"
        }
    }
}
