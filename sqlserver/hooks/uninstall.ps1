$setupPath = "{{pkg.path}}\bin"
if("{{cfg.custom_install_media_dir}}" -ne "") {
    $setupPath = "{{cfg.custom_install_media_dir}}"
}
$setupExe = Get-Item (Join-Path $setupPath setup.exe) -ErrorAction SilentlyContinue

Stop-Service 'MSSQL${{cfg.instance}}'

Write-Host "Uninstalling {{cfg.features}}..."
."$setupExe" /Q /ACTION=Uninstall /FEATURES={{cfg.features}} /SUPPRESSPRIVACYSTATEMENTNOTICE=True /INSTANCENAME={{cfg.instance}}
if($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Remove-Item "{{pkg.svc_data_path}}" -Recurse
