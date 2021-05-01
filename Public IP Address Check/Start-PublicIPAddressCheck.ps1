###########################################################################################
# Script Name: Public IP Address Check
# Script Purpose: Sends and email alert if the public IP address of the device changes
# Created By: Woodward.Digital
# Website: https://woodward.digital
# Email: contact@woodward.digital
# Version: v1.0
###########################################################################################

# Variables
###########################################################################################

# Find currenlt public IP Address
# Run the following command in a PowerShell Console
# (Invoke-WebRequest ipecho.net/plain).content

# Enter the current public IP address below
$CurrentPublicIP = "8.8.8.8"

# Email alert settings

# Where to send the email alerts to
$EmailTo = "<Email Address>"

# SMTP Server details
$SMTPServer = "<SMTP Server Address>"
$SMTPPort = "<SMTP Server Port>"

# SMTP authentication details
$EmailAuthUser = "<SMTP Username>"
$EmailAuthPassword = "<SMTP Password>"

###########################################################################################

# Email Authentication
$SecuredEmailAuthPassword = ConvertTo-SecureString $EmailAuthPassword -AsPlainText -Force
$EmailAuth = New-Object System.Management.Automation.PSCredential ($EmailAuthUser, $SecuredEmailAuthPassword)


# Check public IP address
if ((Invoke-WebRequest ipecho.net/plain).content -eq $CurrentPublicIP){
# IP address hasn't changed
# Uncomment line below if you want to recive an email to confrim it hasnt changed
# Send-MailMessage -Body "IP Address is has not changed" -From $EmailAuthUser -To $EmailTo -Subject "IP address has not changed" -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $EmailAuth
}
Else{
# IP address has changed
Send-MailMessage -Body "IP Address is has changed" -From $EmailAuthUser -To $EmailTo -Subject "IP Address Change - ALERT" -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $EmailAuth
}