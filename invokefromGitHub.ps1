Function New-ModulefromGitHub {
    <#
    .SYNOPSIS
    Takes a Github Raw url, downloads the Powershell Script and Executes as a Dynamic Module

    .DESCRIPTION
    Takes a Github Raw url, downloads the Powershell Script and Executes as a Dynamic Module

    Examples:
    New-ModulefromGitHub -ScriptUrl <Github Raw URL for the Powershell script> -Name "GibModule"

    .PARAMETER ScriptUrl
    GitHub Raw Url for Powershell script/module

    .PARAMETER Name
    A String to identify the Dynamic Module name

    .OUTPUTS
    Loads a Dynamic Module into the current session

    #>     
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [String]$ScriptUrl,
        [Parameter(Mandatory=$true,Position=1)]
        [String]$Name
    )
    if ($ScriptUrl) {
        try {
            $Response = Invoke-WebRequest -Uri $ScriptUrl -UseBasicParsing -ErrorAction SilentlyContinue
            $StatusCode = $Response.StatusCode
        }
        catch {
            $StatusCode = $_.Exception.Response.StatusCode
            Write-Warning "Cannot locate Script Url $ScriptUrl - Status:$StatusCode"
        }
        if ($StatusCode -eq 200) {
            try {
                New-Module -Name $Name -ScriptBlock ([ScriptBlock]::Create($Response.Content))
            }
            catch {
                Write-Error "ScriptUrl is not a valid Powershell Module ScriptBlock"
            }           
        }
    } else {
        Write-Warning "You must enter a Script URL"
    }
}


Function Invoke-FromGitHub {
    <#
    .SYNOPSIS
    Takes a Github Raw url, downloads the Powershell Script and Executes In-line in the current Scope

    .DESCRIPTION
    Takes a Github Raw url, downloads the Powershell Script and Executes in the current scope as if it had been 
    Dot-Sourced. The script is executed in the current scope so variables and functions are available to
    the calling script after execution 

    Examples:
    New-FromGitHub -ScriptUrl <Github Raw URL for the Powershell script>

    .PARAMETER ScriptUrl
    GitHub Raw Url to Powershell script

    .PARAMETER Arglist
    Array or arguments passed as parameters to the command ScriptBlock

    .OUTPUTS
    Executes the command and captures the return status

    #>     
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true,Position=0)]
        [String]$ScriptUrl,
        [object[]]$ArgList
    )
    $Status=$null
    if ($ScriptUrl) {
        try {
            $Response = Invoke-WebRequest -Uri $ScriptUrl -UseBasicParsing -ErrorAction SilentlyContinue
            $StatusCode = $Response.StatusCode
        }
        catch {
            $StatusCode = $_.Exception.Response.StatusCode
            Write-Warning "Cannot locate Script Url $ScriptUrl - Status:$StatusCode"
        }
        if ($StatusCode -eq 200) {
            try {
                $ScriptBlock = [ScriptBlock]::Create($Response.Content)
                $Status = Invoke-Command -Command $ScriptBlock -NoNewScope -ArgumentList $ArgList
            }
            catch {
                Write-Error "ScriptUrl is not a valid Powershell Module ScriptBlock"
            }           
        }
    } else {
        Write-Warning "You must enter a Script URL"
    }
    return $Status
}