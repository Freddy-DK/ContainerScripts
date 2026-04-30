function Get-PlainText() {
    [CmdletBinding()]
    Param(
        [parameter(ValueFromPipeline, Mandatory = $true)]
        [System.Security.SecureString] $SecureString
    )
    $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString)
    try {
        return [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
    }
    finally {
        [Runtime.InteropServices.Marshal]::FreeBSTR($bstr)
    }
}

$tenantId = 'default'
$tenantDatabaseName = "$($ENV:DatabaseName)-$tenantId"

$CustomConfigFile =  Join-Path $ServiceTierFolder "CustomSettings.config"
$CustomConfig = [xml](Get-Content $CustomConfigFile)
$tenantEnvironmentType = $customConfig.SelectSingleNode("//appSettings/add[@key='TenantEnvironmentType']")
$DatabaseServerInstance = "$DatabaseServer"
if ("$DatabaseInstance" -ne "") {
    $DatabaseServerInstance += "\$DatabaseInstance"
}
$Params = @{ "Force"=$true; "AllowAppDatabaseWrite" = $false; "OverwriteTenantIdInDatabase" = $true }
if ($tenantEnvironmentType -ne $null) {
    $Params += @{"EnvironmentType" = $tenantEnvironmentType.value }
}

Write-Host "Mounting tenant '$tenantId' with database '$($DatabaseServerInstance):$tenantDatabaseName' on '$ServerInstance'"
Write-Host $databaseCredentials.Username
$pw = (Get-PlainText $databaseCredentials.Password)
Write-Host $pw
Write-Host $pw.Length

Mount-NavTenant -ServerInstance $ServerInstance -Tenant $tenantId -DatabaseName $tenantDatabaseName -DatabaseCredentials $databaseCredentials @Params -WarningAction SilentlyContinue -Verbose

Write-Host "Sync'ing Tenant"    
Sync-NAVTenant  -ServerInstance $ServerInstance `
                -Tenant $tenantId `
                -Force

