. c:\run\SetupDatabase.ps1

# CreateEncryptionKey.ps1
# Uploads c:\run\my\DynamicsNAV.key to blob storage if the blob doesn't already exist.
$sasUrl = $env:EncryptionKeyBlobSasUrl
if ($sasUrl) {
    $keyPath = 'c:\run\my\DynamicsNAV.key'
    if (Test-Path $keyPath) {
        $bytes = [System.IO.File]::ReadAllBytes($keyPath)
        $headers = @{ 'x-ms-blob-type' = 'BlockBlob'; 'If-None-Match' = '*' }
        try {
            Invoke-WebRequest -Uri $sasUrl -Method Put -Headers $headers -Body $bytes -UseBasicParsing -ErrorAction Stop
            Write-Host "Encryption key uploaded to blob storage."
        }
        catch {
            if ($_.Exception.Response.StatusCode.value__ -eq 409) {
                Write-Host "Encryption key already exists in blob storage (skipped)."
            }
            else {
                throw
            }
        }
    }
}