Function Get-TabloAirings {
    Begin {
        Write-Verbose "Beginning to get recordings IDs from $($ConfigValues['TabloFQDN'])"
    }

    Process {
        $request = Invoke-TabloAPIRequest -Method GET -request '/recordings/airings'

        [System.Collections.ArrayList]$Recordings = @()
        foreach ($Obj in $request) {
            $ObjSplit = $Obj.Split('/').Where{$PSItem}
            [void]$Recordings.Add((
                [PSCustomObject]@{
                    'RecID' = $ObjSplit[-1];
                    'Type' = $ObjSplit[1]
                }
            ))
        }
    }

    End {
        $Recordings
    }
}