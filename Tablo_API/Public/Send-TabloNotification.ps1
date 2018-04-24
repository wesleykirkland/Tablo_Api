Function Send-TabloNotification {
    [CmdletBinding(DefaultParameterSetName='Slack')]
    param (
        [Parameter(Mandatory=$false,ParameterSetName='SMTP')]
        [boolean]$SMTPNotifications,
    
        [Parameter(Mandatory=$false,ParameterSetName='Slack')]
        [boolean]$SlackNotifications,

        [Parameter(Mandatory=$true)]
        [string]$Message,

        [Parameter(Mandatory=$true,ParameterSetName='Slack')]
        [string]$SlackWebHookURL,

        [Parameter(Mandatory=$true,ParameterSetName='Slack')]
        [string]$SlackChannel,
        
        [Parameter(Mandatory=$true,ParameterSetName='SMTP')]
        [string]$SMTPServer,

        [Parameter(Mandatory=$true,ParameterSetName='SMTP')]
        [string]$SMTPTo,

        [Parameter(Mandatory=$true,ParameterSetName='SMTP')]
        [string]$SMTPFrom,

        [Parameter(Mandatory=$false,ParameterSetName='SMTP')]
        [string]$Subject = $Message
        
    )

    Begin {
        Write-Verbose 'Preparing to send notification'
    }

    Process {
        if ($SlackNotifications) {
            Write-Verbose 'Sending Slack Notification'
            [void](Send-SlackNotification -SlackWebHook $SlackWebHookURL -SlackChannel $SlackChannel -Message $Message -ErrorVariable ErrorSlack)
        }
        
        if ($SMTPNotifications) {
            Write-Verbose 'Sending Email Notification'
            [void](Send-MailMessage -From $SMTPFrom -To $SMTPTo -SmtpServer $SMTPServer -Subject $Subject -Body $Message -ErrorVariable ErrorSMTP)
        }
    }

    End {
        if ($ErrorSlack) {
            $ErrorSlack
        }

        if ($ErrorSMTP) {
            $ErrorSMTP
        }
    }
}