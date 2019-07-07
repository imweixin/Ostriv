function IsNullOrWhiteSpace {
    param (
        [string]$str
    )
    if ($str) {
        return ($str.Trim() -replace " ", "" -replace "`t", "").Length -eq 0
    }
    else {
        return $true
    }
}

function Get-ScriptDirectory {
    Split-Path -parent $PSCommandPath
}