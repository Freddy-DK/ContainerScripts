. c:\run\SetupConfiguration.ps1

if ($auth -eq "AccessControlService") {
    # Set ValiddAudiences
    # Set tenant in ADOpenIdMetadataLocationNode
    $CustomConfigFile =  Join-Path $ServiceTierFolder "CustomSettings.config"
    Get-Content $CustomConfigFile | Out-Host
}
