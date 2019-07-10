function InstallModule {
    param (
        [string]$moduleName
    )
    if (!(Get-Module -Name $moduleName -ListAvailable -ErrorAction SilentlyContinue)) {
        Find-Module -Name $moduleName -Repository 'PSGallery' | Save-Module -Path $PSHOME/Modules
    }
    else {
        Write-Output "Module Exists"
    }
    
}