function NewFileIfNotExists {
    param (
        [string]$fileName
    )
    if (Test-Path -Path $fileName -IsValid) {
        if (Test-Path -Path $fileName) {
            return $true
        }
        else {
            New-Item -Path $fileName -ItemType File -Force | Out-Null
            return $false
        }
    }
    else {
        if ([string]::IsNullOrWhiteSpace($fileName) ) {
            throw [System.IO.IOException] "file name or path is null or empty!"
        }
        else {
            throw [System.IO.IOException] "$fileName is invalid!"
        }    
    }
}

function WriteToFile {
    param (
        [Parameter(Mandatory = $true)] [string]$fileName, 
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [AllowEmptyString()] $content,
        [Parameter(Mandatory = $false)] [bool]$append = $false
    )
    Out-File -FilePath $fileName -Encoding utf8NoBOM -Append $append -Width 120 -InputObject $content
}

function ReadFromFile {
    param (
        [string]$fileName
    )
    Write-Output "hello world"
}

function EncryptFile {
    param (
        [string]$fileName
    )
    Write-Output "hello world"
}

function DecryptFile {
    param (
        [string]$fileName
    )
    Write-Output "hello world"
}

function ExtractFile {
    param (
        [string]$fileName
    )
    Write-Output "hello world"
}

function CompressFile {
    param (
        [string]$fileName
    )
    Write-Output "hello world"
}

# Export-ModuleMember -Function @('TestFilePath','WriteToFile','ExtractFile','ReadFromFile')