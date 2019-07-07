function DownloadFromUri {
    param (
        [string]$uri,
        [string]$fileName,
        [string]$method
    )
    Invoke-WebRequest -Uri $uri -OutFile $fileName
}