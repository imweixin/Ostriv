
function GetPwshFullPath {
    $pwsh = Get-ChildItem -Path $PSHOME -Include p* | Where-Object { $_.Name -match '^(pwsh|powershell)(\.exe)?$' } | Select-Object -First 1
    return ($pwsh.ToString())
}

function CheckCommandExists {
    param (
        [string]$cmdName
    )
    return [bool](Get-Command -Name $cmdName -ErrorAction SilentlyContinue)
}
function ExecuteCommand {
    param (
        [Parameter(ValueFromPipeline = $true)] [Hashtable]$hashtable
    )
    # Write-Output $hashtable.PSBase.Keys
    # Write-Output $hashtable.Keys
    
    if ($IsWindows) {
        if ($hashtable["Windows"][0] -eq '"') {
            Invoke-Expression ("& " + $hashtable["Windows"])
        }
        else {
            Invoke-Expression $hashtable["Windows"]
        }    
    }
    elseif ($IsLinux) {
        Write-Output $hashtable["Linux"]
    }
    elseif ($IsMacOS) {
        Write-Output $hashtable["MacOS"]
    }
    else {
        throw "Unknown Platform"
    }
}