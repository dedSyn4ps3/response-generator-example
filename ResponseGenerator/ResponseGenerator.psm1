<#
.SYNOPSIS
Simple Windows form utility for generating quick response messages.

.DESCRIPTION
As IT Support Professionals, we are constantly sending correspondance to various clients and end users. 
Very rarely do we help only one or two customer groups each day, and because of that fact, it's normal 
for us to have to create tailored response messages with contact info specific to that client.

.EXAMPLE
PS > Invoke-ResponseGenerator

***Launch response utility from commandline***

.NOTES
Author: dedSyn4ps3 (Ed Rutherford)
Date: July 19, 2023
#>

. $env:HOMEDRIVE$env:HOMEPATH"\Documents\WindowsPowerShell\Modules\ResponseGenerator\ResponseForm.ps1"

function Invoke-ResponseGenerator { 
    # Start frontend UI
    Initialize-FormUI
}

Export-ModuleMember -Function Invoke-ResponseGenerator