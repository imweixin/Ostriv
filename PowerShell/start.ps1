Import-Module -Name $PSScriptRoot/base/base
Import-Module -Name $PSScriptRoot/base/common.psm1

$greetings = "Welcome to"
if ($IsWindows) {
    Write-Output "$greetings Windows"
}
elseif ($IsLinux) {
    Write-Output "$greetings Linux"
}
elseif ($IsMacOS) {
    Write-Output "$greetings MacOS"
}
else {
    Write-Error -Message "Unknown Platform" -Category NotImplemented
    return
}

# Prepare to write to file
$url = 'https://docs.microsoft.com/en-us/dotnet/opbuildpdf/toc.pdf?branch=live'
$fileName = "~/Downloads/.Net.pdf"
# DownloadFromUrl -url $url -output $fileName 
ExecuteCommand(@{Windows = 'echo "hello win"'; MacOS = "m"; Linux = "l" })

