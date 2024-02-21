# invokePSTask

Example of executing Powershell (and Powershell Core) Tasks directly from Github

2 Options are available

Option 1: Download and invoke script. Optionally passing any parameters

Which this option the Script referenced by the Url is downloaded as a ScriptBlock and
executed on the local computer using Invoke-Command. The script runs in its own scope and can pass parameters.


Option 2: Download script and set up as a dynamic Module

A Powershell function takes a GitHub raw URL, downloads and installs as a dynamic Module.

Insert the function in your script. 
