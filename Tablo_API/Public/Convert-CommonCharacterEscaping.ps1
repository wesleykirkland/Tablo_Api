Function Convert-CommonCharacterEscaping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$string,

        [Parameter(Mandatory=$false)]
        [switch]$Unescape
    )

    Begin {
        Write-Verbose "Character Escaping $string for common things"

        #Build a object to hold our replacement strings
        [System.Collections.ArrayList]$ObjReplacements = @()
        
        #Single Quotes
        [void]$ObjReplacements.Add(
            [pscustomobject]@{
                'Input' = "'" ;
                'Output' = "''";
                'ReverseEscape' = $true;
            }
        )

        #Colons
        [void]$ObjReplacements.Add(
            [pscustomobject]@{
                'Input' = ':' ;
                'Output' = '';
                'ReverseEscape' = $false;
            }
        )

        [void]$ObjReplacements.Add(
            [pscustomobject]@{
                'Input' = 'â';
                'Output' = '-';
                'ReverseEscape' = $false;
            }
        )
    }

    Process {
        if (!($Unescape)) {
            foreach ($Escape in $ObjReplacements) {
                $string = $string -replace $Escape.Input, $Escape.Output
            }

        } else {
            Write-Verbose 'Unescapping characters'

            #Don't undo blank space, that will end bad!
            foreach ($Escape in $ObjReplacements.Where{$PSItem.ReverseEscape}) {
                $string = $string -replace $Escape.Output, $Escape.Input
            }
        }
    }

    End {
        $string
    }
}