Function Get-TabloConfig {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [System.Object]$ConfigValues
    )

    Begin {
        Write-Verbose 'Recieved data and going to convert it to a Hashtable'
    }
    
    Process {
        Write-Verbose 'Building Hashtable'
        $ConfigHashTable = @{}
        $ConfigValues.psobject.BaseObject | ForEach-Object {
            $ConfigHashTable[$PSItem.ConfigKey] = $PSItem.ConfigValue
        }
    }

    End {
        Write-Verbose 'Outputting HashTabloe'
        $ConfigHashTable
    }
}

