$tenantDatabaseName = "$($ENV:DatabaseName)-default"
$CustomConfigFile =  Join-Path $ServiceTierFolder "CustomSettings.config"
$CustomConfig = [xml](Get-Content $CustomConfigFile)
$tenantEnvironmentType = $customConfig.SelectSingleNode("//appSettings/add[@key='TenantEnvironmentType']")

$Params = @{ "Force"=$true; "AllowAppDatabaseWrite" = $false }
if ($tenantEnvironmentType -ne $null) {
    $Params += @{"EnvironmentType" = $tenantEnvironmentType.value }
}
Mount-NavTenant -ServerInstance $ServerInstance -Tenant 'default' -DatabaseName $tenantDatabaseName @Params -WarningAction SilentlyContinue
