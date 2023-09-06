<#

This file defines the components needed to create the form interface of the 
utility. Along with the various UI declarations, it also defines a number of 
callback functions that get triggered by corresponding user interactions:

1. New-ComboBoxResponse
2. New-ShortcutResponse

#>

. $env:HOMEDRIVE$env:HOMEPATH"\Documents\WindowsPowerShell\Modules\ResponseGenerator\ResponseCore.ps1"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName PresentationCore, PresentationFramework

# Enable Visual Styles
[Windows.Forms.Application]::EnableVisualStyles()

######################################
#        Callback Functions          #
######################################

function New-ComboBoxResponse {
    try {
        # Pass selected location and retrieve details
        $_location = $comboBox.SelectedItem
        $_comboDetails = Get-LocationDetails -Location $_location
        $_tech = Get-TechName

        $_text = New-ResponseGeneratorText -Tech $_tech -Phone $_comboDetails.Phone -Email $_comboDetails.Email -Title $_comboDetails.Title
        Write-ResponseGeneratorText -Text $_text

        Invoke-ConfirmationMessage
    }
    catch {
        Invoke-FailMessage($_.Exception.Message)
    }
}

function New-ShortcutResponse {
    param(
        [parameter(Mandatory = $true)]
        [String]$Selection
    )

    try {
        $_tech = Get-TechName

        # Pass selected location and retrieve details
        $_shortcutDetails = Get-LocationDetails -Location $Selection
        $_text = New-ResponseGeneratorText -Tech $_tech -Phone $_shortcutDetails.Phone -Email $_shortcutDetails.Email -Title $_shortcutDetails.Title
        Write-ResponseGeneratorText -Text $_text

        Invoke-ConfirmationMessage
    }
    catch {
        Invoke-FailMessage($_.Exception.Message)
    }

}

function Invoke-ConfirmationMessage {
    $ms = 2000
    $path = (Get-Process -id $pid).Path
    $confirm_notifier = New-Object System.Windows.Forms.NotifyIcon

    $confirm_notifier.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
    $confirm_notifier.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info 
    $confirm_notifier.BalloonTipText = "Selection copied to clipboard!"
    $confirm_notifier.BalloonTipTitle = "Response Generator" 

    $confirm_notifier.Visible = $true 
    $confirm_notifier.ShowBalloonTip($ms)
}

function Invoke-FailMessage($message) {
    $ms = 2000
    $path = (Get-Process -id $pid).Path
    $fail_notifier = New-Object System.Windows.Forms.NotifyIcon

    $fail_notifier.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
    $fail_notifier.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Error 
    $fail_notifier.BalloonTipText = "$message"
    $fail_notifier.BalloonTipTitle = "Response Generator" 

    $fail_notifier.Visible = $true 
    $fail_notifier.ShowBalloonTip($ms)
}

function Initialize-FormUI {
    $icon_path = $env:HOMEDRIVE + $env:HOMEPATH + "\Documents\WindowsPowerShell\Modules\ResponseGenerator\assets\coding.ico"
    # Base form
    $form = New-Object System.Windows.Forms.Form
    $form.Icon = [System.Drawing.Icon]::new($icon_path)
    $form.Text = 'Response Generator'
    $form.Size = New-Object System.Drawing.Size(600, 400)
    $form.StartPosition = 'CenterScreen'

    ########################################
    #             Form Header              #
    ########################################

    # Image
    $banner = New-Object System.Windows.Forms.PictureBox

    $banner.ImageLocation = "https://www.coldwater.org/ImageRepository/Document?documentID=1966"
    $banner.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage
    $banner.Size = New-Object System.Drawing.Size(600, 120)
    $banner.Dock = [System.Windows.Forms.DockStyle]::Top
    $form.Controls.Add($banner)

    # Label
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(170, 125)
    $label.Size = New-Object System.Drawing.Size(325, 25)
    $label.Text = 'IT Support Response Generator'
    $label.Font = New-Object System.Drawing.Font("Cooper Black", 12, [System.Drawing.FontStyle]::Bold)
    $form.Controls.Add($label)

    ########################################
    #          Customer Dropdown           #
    ########################################

    $customer_label = New-Object System.Windows.Forms.Label
    $customer_label.Location = New-Object System.Drawing.Point(10, 165)
    $customer_label.Size = New-Object System.Drawing.Size(280, 20)
    $customer_label.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $customer_label.Text = 'Customer Selection:'
    $form.Controls.Add($customer_label)

    # Add Items
    $comboBox = New-Object System.Windows.Forms.ComboBox
    $comboBox.Location = New-Object System.Drawing.Point(12, 190)
    $comboBox.Width = 300

    [void] $comboBox.Items.Add('SFV')
    [void] $comboBox.Items.Add('WWC')
    [void] $comboBox.Items.Add('MIDW')
    [void] $comboBox.Items.Add('EAST')

    $form.Controls.Add($comboBox)

    # Generate response for selection
    $generateButton = New-Object System.Windows.Forms.Button
    $generateButton.Location = New-Object System.Drawing.Point(325, 188)
    $generateButton.Size = New-Object System.Drawing.Size(75, 25)
    $generateButton.Text = 'GENERATE'
    $generateButton.Add_Click({ New-ComboBoxResponse })

    $form.Controls.Add($generateButton)

    #######################################
    #          Shortcut Buttons           #
    #######################################

    $shortcuts_label = New-Object System.Windows.Forms.Label
    $shortcuts_label.Location = New-Object System.Drawing.Point(10, 230)
    $shortcuts_label.Size = New-Object System.Drawing.Size(280, 20)
    $shortcuts_label.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $shortcuts_label.Text = 'Quick Select:'
    $form.Controls.Add($shortcuts_label)


    # SFV
    $sfvButton = New-Object System.Windows.Forms.Button
    $sfvButton.Location = New-Object System.Drawing.Point(70, 265)
    $sfvButton.Size = New-Object System.Drawing.Size(100, 50)
    $sfvButton.Text = 'SFV'
    $sfvButton.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
    $sfvButton.Add_Click({ New-ShortcutResponse -Selection "SFV" })
    $form.Controls.Add($sfvButton)

    # WWC
    $wwcButton = New-Object System.Windows.Forms.Button
    $wwcButton.Location = New-Object System.Drawing.Point(190, 265)
    $wwcButton.Size = New-Object System.Drawing.Size(100, 50)
    $wwcButton.Text = 'WWC'
    $wwcButton.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
    $wwcButton.Add_Click({ New-ShortcutResponse -Selection "WWC" })
    $form.Controls.Add($wwcButton)

    # MIDW
    $midwButton = New-Object System.Windows.Forms.Button
    $midwButton.Location = New-Object System.Drawing.Point(310, 265)
    $midwButton.Size = New-Object System.Drawing.Size(100, 50)
    $midwButton.Text = 'MIDW'
    $midwButton.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
    $midwButton.Add_Click({ New-ShortcutResponse -Selection "MidwestU" })
    $form.Controls.Add($midwButton)

    # EAST
    $eastButton = New-Object System.Windows.Forms.Button
    $eastButton.Location = New-Object System.Drawing.Point(430, 265)
    $eastButton.Size = New-Object System.Drawing.Size(100, 50)
    $eastButton.Text = 'EAST'
    $eastButton.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Regular)
    $eastButton.Add_Click({ New-ShortcutResponse -Selection "EastCoast" })
    $form.Controls.Add($eastButton)


    ################################
    #          Show Form           #
    ################################

    $form.ShowDialog()
}

Initialize-FormUI