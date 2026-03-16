$ENV:DatabaseInstance = ''
if ("$env:licensefile" -eq "") {
    $ENV:licensefile = @(Get-Item "C:\Program Files\Microsoft Dynamics NAV\*\Service\*.bclicense")[0].FullName
}
. c:\run\SetupVariables.ps1
