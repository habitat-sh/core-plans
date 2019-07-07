Configuration test_with_resource
{
    Node 'localhost'
    {
        File test_directory
        {
            Type = 'Directory'
            DestinationPath = 'C:\test_directory'
            Ensure = 'Present'
        }
    }
}

Configuration test_with_resource_config_data
{
    Node 'localhost'
    {
        $password = ConvertTo-SecureString $node.Password -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList ($node.Username, $password)

        File test_directory
        {
            Type = 'Directory'
            DestinationPath = $node.DestinationPath
            Ensure = 'Present'
            Credential = $Credential
        }
    }
}

Configuration test_without_resource
{
    Node 'localhost'
    {

    }
}

Configuration test_cleanup
{
    Node 'localhost'
    {
        File test_directory
        {
            Type = 'Directory'
            DestinationPath = 'C:\test_directory'
            Ensure = 'Absent'
        }
        File test_directory1
        {
            Type = 'Directory'
            DestinationPath = 'C:\test_directory1'
            Ensure = 'Absent'
        }
    }
}
