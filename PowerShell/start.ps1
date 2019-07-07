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
$fileName = "$PSScriptRoot/test/test.txt"
NewFileIfNotExists($fileName)
ExecuteCommand(@{Windows = 'echo "hello win"'; MacOS = "m"; Linux = "l" })

