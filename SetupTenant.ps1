$tenantDatabaseName = "$($ENV:DatabaseName)-default"
$CustomConfigFile =  Join-Path $ServiceTierFolder "CustomSettings.config"
$CustomConfig = [xml](Get-Content $CustomConfigFile)
$tenantEnvironmentType = $customConfig.SelectSingleNode("//appSettings/add[@key='TenantEnvironmentType']")
$DatabaseServerInstance = "$DatabaseServer"
if ("$DatabaseInstance" -ne "") {
    $DatabaseServerInstance += "\$DatabaseInstance"
}
Write-Host "Mounting tenant 'default' with database '$tenantDatabaseName' on database server instance '$DatabaseServerInstance'... on '$ServerInstance'" -ForegroundColor Green

$Params = @{ "Force"=$true; "AllowAppDatabaseWrite" = $false; "OverwriteTenantIdInDatabase" = $true }
if ($tenantEnvironmentType -ne $null) {
    $Params += @{"EnvironmentType" = $tenantEnvironmentType.value }
}
Mount-NavTenant -ServerInstance $ServerInstance -Tenant 'default' -DatabaseName $tenantDatabaseName -DatabaseCredentials $databaseCredentials @Params -WarningAction SilentlyContinue
