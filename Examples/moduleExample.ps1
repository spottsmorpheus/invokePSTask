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

    # Trivial example creates an object whic will be returned
    $InstanceInfo = @{
        MorpheusInstance = $Instance;
        MachineName = [Environment]::MachineName;
        UserName = [Environment]::UserName
    }
 
    return $InstanceInfo
}

Write-Output "Loaded $($Title) - $($Version)" -ForegroundColor Green

# Use Export-ModuleMember to be explicit about the functions and variables exported. 
# By default all Functions are exported