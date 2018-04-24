Function Get-TabloSeriesMetaData {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [int]$SeriesID
    )

    Begin {
        Write-Verbose "Getting episode metadata for $RecID"
    }

    Process {
        $request = Invoke-TabloAPIRequest -Method GET -Request "/recordings/series/$SeriesID"
    }

    End {
        if (!([string]::IsNullOrWhiteSpace($request.object_id))) {
            Write-Verbose "We have metadata for $SeriesID"
            $request
        } else {
            Write-Warning "No metadata $SeriesID"
        }
    }
}