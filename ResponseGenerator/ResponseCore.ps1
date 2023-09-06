<#

This file defines the core object declarations used by the utility. 
All customer locations, as well as technician info and email contacts are 
listed in this script.

Exported helper functions are declared as well:

1. Get-LocationDetails
2. New-ResponseGeneratorText
3. Write-ResponseGeneratorText

#>

$name = whoami

$EAST_TITLE = "East Coast Help Desk"
$EAST_EMAIL = "support.east@nr.com"
$WEST_EMAIL = "support.west@nr.com"
$WEST_TITLE = "West Coast Service Desk"

$techs = @{
    "nrit\jdoe"       = "Johnny Doe"
    "nrit\bobama"     = "Bob Ama"
    "nrit\nisix"      = "Nik Six"
    "nrit\dedsyn4ps3" = "Ed Rutherford"
}


$sites = @{
    SFV           = "555-999-5555"
    WWC           = "333-888-2222"
    MidwestU      = "111-771-6622"
    EastCoast     = "999-667-8338"
}


#####################################
#             Exported              #
#         Helper Functions          #
#####################################

function Get-TechName { 
    return $techs[$name]
}

function Get-LocationDetails { 
    param(
        [parameter(Mandatory = $true)]
        [String]$Location
    )

    switch ($Location) {
        "EastCoast" {
            $details = [pscustomobject]@{
                Title = $EAST_TITLE
                Email = $EAST_EMAIL
                Phone = $sites[$Location]
            }
        }
        default {
            $details = [pscustomobject]@{
                Title = $WEST_TITLE
                Email = $WEST_EMAIL
                Phone = $sites[$Location]
            }
        }
    }

    return $details
}
function New-ResponseGeneratorText {
    param(
        [parameter(Mandatory = $true)]
        [String]$Tech,

        [parameter(Mandatory = $true)]
        [String]$Phone,

        [parameter(Mandatory = $true)]
        [String]$Email,

        [parameter(Mandatory = $true)]
        [String]$Title
    )

    $response_text = "Thank you so much for contacting the $Title!

    If you have any additional issues, please contact the $Title at $Phone or email at $Email and we will address them immediately. 
    Have a fantastic day!
    
    Sincerely,
    
    $Tech
    $Phone"

    return $response_text
}

function Write-ResponseGeneratorText {
    param(
        [parameter(Mandatory = $true)]
        [String]$Text
    )

    # Copy generated text to clipboard
    Set-Clipboard -Value "$Text"
}
