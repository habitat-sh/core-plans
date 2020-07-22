function ConvertTo-SecurePassword {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
    param($plainText)

    ConvertTo-SecureString $plainText -AsPlainText -Force
}

# Create application Users

if('{{cfg.app_user}}' -ne '') {
    $instance = "{{cfg.instance}}"
    $listening = $false
    while(!$listening) {
        Write-Host "waiting for sql server to start accepting connections..."
        Start-Sleep -Seconds 3
        try{
            $listening = New-Object System.Net.Sockets.TCPClient -ArgumentList localhost,{{cfg.port}} -ErrorAction SilentlyContinue | Where-Object { $_.Connected }
        } catch { $listening = $false }
    }

    $saPassword = ConvertTo-SecurePassword '{{cfg.sa_password}}'
    $saCred = New-Object System.Management.Automation.PSCredential ('sa', $saPassword)

    if(!(Get-SqlLogin -LoginName {{cfg.app_user}} -Credential $saCred -ServerInstance "localhost\$instance" -ErrorAction SilentlyContinue)) {
        Write-Host "Starting application user setup..."
        if('{{cfg.app_password}}' -eq '') {
            add-SqlLogin -LoginName {{cfg.app_user}} -Credential $saCred -ServerInstance "localhost\$instance" -LoginType WindowsUser -Enable -GrantConnectSql
        } else {
            $loginPassword = ConvertTo-SecurePassword '{{cfg.app_password}}'
            $loginCred = New-Object System.Management.Automation.PSCredential ('{{cfg.app_user}}', $loginPassword)
            add-SqlLogin -LoginName {{cfg.app_user}} -Credential $saCred -ServerInstance "localhost\$instance" -LoginType SqlLogin -LoginPSCredential $loginCred -Enable -GrantConnectSql | Out-Null
        }
        Invoke-Sqlcmd -Credential $saCred -ServerInstance "localhost\$instance" -Query "create user [{{cfg.app_user}}] for login [{{cfg.app_user}}]" | Out-Null
        Invoke-Sqlcmd -Credential $saCred -ServerInstance "localhost\$instance" -Query "grant CREATE DATABASE to [{{cfg.app_user}}]" | Out-Null
        Write-Host "Application user setup complete"
    }
}
