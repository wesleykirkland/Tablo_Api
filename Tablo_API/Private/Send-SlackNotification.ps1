function Send-SlackNotification {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$SlackWebHook,

        [Parameter(Mandatory=$true)]
        [string]$SlackChannel,

        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    $JSON = ConvertTo-Json(
        @{
            channel      = $SlackChannel;
            unfurl_links = "true";
            username     = "Tablo API";
            icon_url     = "https://www.rokuchannels.tv/wp-content/uploads/2015/02/tablotv.jpg"
            text         = "$Message";
        }
    )

    Invoke-RestMethod -Method POST -Uri $SlackWebHook -Body $JSON
}