. c:\run\SetupWebConfiguration.ps1

if ($auth -eq "AccessControlService") {
    $navsettingsFile = Join-Path $wwwRootPath "$webServerInstance\navsettings.json"
    Get-Content $navSettingsFile | Out-Host
  # "ClientServicesCredentialType":  "AccessControlService",
  # "AadApplicationId":  "ed7088a0-0f8e-4b7b-8801-21dc2d68ffa5",
  # "AadAuthorityUri":  "https://login.microsoftonline.com/164d3b0c-8dca-45a9-9300-17a0e8bc3325",
}
