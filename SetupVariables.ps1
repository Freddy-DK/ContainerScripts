$ENV:DatabaseInstance = ''
if ("$env:licensefile" -eq "") {
    $ENV:licensefile = @(Get-Item "C:\Program Files\Microsoft Dynamics NAV\*\Service\*.bclicense")[0].FullName
}
# ReadEncryptionKey.ps1
# If EncryptionKeyBlobSasUrl is set and the blob exists, downloads it to c:\run\my\DynamicsNAV.key
Write-Host "Checking for encryption key in blob storage..."
$sasUrl = $env:EncryptionKeyBlobSasUrl
if ($sasUrl) {
    Write-Host "EncryptionKeyBlobSasUrl is set. Attempting to download encryption key from blob storage..."
    $targetPath = 'c:\run\my\DynamicsNAV.key'
    try {
        Invoke-WebRequest -Uri $sasUrl -Method Get -OutFile $targetPath -UseBasicParsing -ErrorAction Stop
        Write-Host "Encryption key downloaded to $targetPath"
    }
    catch {
        if ($_.Exception.Response.StatusCode.value__ -eq 404) {
            Write-Host "No encryption key found in blob storage (first run)."
        }
        else {
            throw
        }
    }
}
. c:\run\SetupVariables.ps1
