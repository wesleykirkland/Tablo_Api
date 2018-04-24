Function Get-TabloEpisodeMetaData {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [int]$RecID
    )

    Begin {
        Write-Verbose "Getting episode metadata for $RecID"
    }

    Process {
        $request = Invoke-TabloAPIRequest -Method GET -Request "/recordings/series/episodes/$RecID"

        if (!([string]::IsNullOrWhiteSpace($request.episode.tms_id))) {
            Write-Verbose "We have metadata for $RecID"
            $request
        } else {
            Write-Warning "No metadata for $RecID"
        }
    }

    End {}
}