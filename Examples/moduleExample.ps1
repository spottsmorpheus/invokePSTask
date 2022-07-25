# This example shows how Dynamic Modules can be executed directly from a Git raw url.
   
# In this script we will define functions which will then be available for use by the 
# task executing in Morpheus 

# This shows how a Script level varable may be defined and made available to the calling script
$Title = "moduleExample.ps1"
$Version = "1.0"

function Get-InstanceInfo {
    param (
        [String]$Instance
    )

    Write-Host "This value of parameter Instance is $($Instance)"
    return $Instance
}

Write-Host "Loaded $($Title) - $($Version)" -ForegroundColor Green

# Use Export-ModuleMember to be explicit about the functions and variables exported. 
# By default all Functions are exported