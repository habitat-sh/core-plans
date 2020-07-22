$ProgressPreference="SilentlyContinue"
$sqlMajorVersion = [Version]::new("{{pkg.version}}").Major
$setupPath = "{{pkg.path}}\bin"
if("{{cfg.custom_install_media_dir}}" -ne "") {
    $setupPath = "{{cfg.custom_install_media_dir}}"
}
$setupExe = Get-Item (Join-Path $setupPath setup.exe) -ErrorAction SilentlyContinue
if($setupExe) {
    $sqlMajorVersion = [Version]::new($setupExe.VersionInfo.ProductVersion).Major
}

# Configure the instance for the configured port
Set-ItemProperty -Path  "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL${sqlMajorVersion}.{{cfg.instance}}\MSSQLServer\SuperSocketNetLib\Tcp\IPAll" -Name TcpPort -Value {{cfg.port}}

# Open port on firewall only if Windows Firewall service is running
if($(Get-Service 'MpsSvc').Status -eq "Running") {
    Start-DscCore (Join-Path {{pkg.svc_config_path}} firewall.ps1) NewFirewallRule
}
