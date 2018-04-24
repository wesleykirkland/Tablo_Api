Function Test-TabloConnection {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]$TabloFQDN = $ConfigValues['TabloFQDN']
    )

    Begin {
        Write-Verbose "Testing if we can ping $($TabloFQDN)"
    }

    Process {
        $TestConnection = Test-Connection -ComputerName $TabloFQDN -Count 1 -ErrorAction Continue -InformationAction 'Ignore'
    }

    End {
        if ($TestConnection) {
            [pscustomobject]@{
                'Ping' = $true
            }
        } else {
            [pscustomobject]@{
                'Ping' = $false
            }
        }
    }
}