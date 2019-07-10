function DownloadFromUrl {
    param (
        [string]$url,
        [string]$output,
        [string]$method = "WebRequest"
    )
    $start_time = Get-Date
    if ($method -eq "WebRequest") {
        Write-Output "WebRequest"
        Invoke-WebRequest -Uri $url -OutFile $output
    }
    elseif ($method -eq "WebClient") {
        Write-Output "WebClient"
        (New-Object System.Net.WebClient).DownloadFile($url, $output)
    }
    Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
}