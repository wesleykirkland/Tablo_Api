Function Invoke-TabloRecordingDownload {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [int]$RecID,

        [Parameter(Mandatory=$true)]
        [string]$FileName,

        [Parameter(Mandatory=$true)]
        [string]$DownloadLocation,

        [Parameter(Mandatory=$true)]
        [string]$FFMPEGBinary,

        [Parameter(Mandatory=$true)]
        [string]$TabloFQDN
    )

    Begin {
        Write-Verbose "Downloading $RecID from Tablo"
    }

    Process {
        $request = Invoke-TabloAPIRequest -Method POST -request "/recordings/series/episodes/$RecID/watch"

        #Verify the recording is finished before we download it
        $RecIDMetaData = Get-TabloEpisodeMetaData -RecID $RecID

        if (!($RecIDMetaData.video_detail.warnings)) {
            #Sometimes the Tablo is stupid and thinks we're external when we're not, Tablo suport keeps saying NAT but we're doing layer 2
            $M3PlaylistURL = "http://$($TabloFQDN)/$($request.playlist_url.split('/')[($request.playlist_url.split('/').Length-2)..5] -join '/')"

            #Normal FileName download
            (& $FFMPEGBinary -y -i $M3PlaylistURL -bsf:a aac_adtstoasc -c copy $DownloadLocation\$FileName.mp4 -user-agent "Tablo API Downloaded - PowerShell")
        }
    }

    End {}
}