function Remove-TabloRecording {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [int]$RecID,

        [Parameter(Mandatory=$true)]
        [ValidateSet('series','sports','movies','programs')]
        [string]$AiringType
    )

    Begin {
        Write-Verbose "Deleting $($RecID) on endpoint $($AiringType)"
    }

    Process {
        #Freaking tablo adjusted part of the endpoint on the delete, not sure why. Maybe one day I will.
        switch ($AiringType) {
            'series' {$Endpoint2 = 'episodes'}
            'sports' {$Endpoint2 = 'events'}
            'movies' {$Endpoint2 = 'airings'}
            'programs' {$Endpoint2 = 'airings'}
        }

        Invoke-TabloAPIRequest -Method DELETE -request "/recordings/$($AiringType)/$Endpoint2/$RecID"
    }

    End {}
}