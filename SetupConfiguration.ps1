. c:\run\SetupConfiguration.ps1

if ($auth -eq "AccessControlService") {
    # Set ValiddAudiences
    # Set tenant in ADOpenIdMetadataLocationNode
    $CustomConfigFile =  Join-Path $ServiceTierFolder "CustomSettings.config"
    $CustomConfig = [xml](Get-Content $CustomConfigFile)
    if ($null -ne $customConfig.SelectSingleNode("//appSettings/add[@key='ValidAudiences']")) {
        $validAudiences = "$($env:aadAppId);$($env:appIdUri);$validAudiences"
        $CustomConfig.SelectSingleNode("//appSettings/add[@key='ValidAudiences']").value = $validAudiences
        $CustomConfig.Save($CustomConfigFile)
    }
    Get-Content $CustomConfigFile | Out-Host
}
