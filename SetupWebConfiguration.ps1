. c:\run\SetupWebConfiguration.ps1

if ($auth -eq "AccessControlService") {
    $navsettingsFile = Join-Path $wwwRootPath "$webServerInstance\navsettings.json"
    $aadApplicationId = "$($env:aadAppId)"
    $aadAuthorityUri = "https://login.microsoftonline.com/$($env:aadTenant)"
    $config = Get-Content $navSettingsFile | ConvertFrom-Json
    Add-Member -InputObject $config.NAVWebSettings -NotePropertyName "AadApplicationId" -NotePropertyValue $aadApplicationId -ErrorAction SilentlyContinue
    $config.NAVWebSettings."AadApplicationId" = $aadApplicationId
    Add-Member -InputObject $config.NAVWebSettings -NotePropertyName "AadAuthorityUri" -NotePropertyValue $aadAuthorityUri -ErrorAction SilentlyContinue
    $config.NAVWebSettings."AadAuthorityUri" = $aadAuthorityUri
    $config | ConvertTo-Json -Depth 10 | Set-Content $navsettingsFile -Force
    Get-Content $navSettingsFile | Out-Host
}
