Write-Host "----------------------------------------------------------"
$CustomConfigFile =  Join-Path $ServiceTierFolder "CustomSettings.config"
Get-Content $CustomConfigFile | Out-Host
Write-Host "----------------------------------------------------------"

. c:\run\SetupLicense.ps1
