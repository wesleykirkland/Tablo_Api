Function Invoke-TabloAPIRequest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Request,

        [Parameter(Mandatory=$false)]
        [ValidateSet('GET','POST','PATCH','DELETE')]
        [string]$Method = 'GET'
    )

    Begin {
        Write-Verbose 'Add a /on the beginning of the URL if doesn''t one exists'
        if ($request[0] -ne '/') {
            $request = "/$($request)"
        }
    }

    Process {
        Write-Verbose "Querying tablo endpoint $request with method $method"
        Try {
            Invoke-RestMethod -Method $Method -Uri "$($TabloAPIBaseURL)$($request)"
        } Catch {
            Write-Error -Message "Failed to query $($TabloAPIBaseURL)$($request)"
            exit
        }
    }

    End {}
}