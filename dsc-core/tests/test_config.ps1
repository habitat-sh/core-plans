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

Configuration test_without_resource
{
    Node 'localhost'
    {

    }
}
