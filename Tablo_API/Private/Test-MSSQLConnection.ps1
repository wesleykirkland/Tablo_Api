Function Test-MSSQLConnection {
    #Params
    [CmdletBinding()]
    Param(
    [parameter(Position=0,Mandatory=$true)]
        $ServerInstance,
    [parameter()]
        [System.Management.Automation.PSCredential]$Cred,
    [parameter()]
        [switch]$NoSSPI = $false
    )

    Begin{}

    Process {
        if ($NoSSPI -and (!($Cred))) {
            $Cred = Get-Credential
        }

        if ($NoSSPI) {
            Write-Verbose 'Setting SQL to use local credentials'
            $connectionString = "Data Source = $ServerInstance;Initial Catalog=master;User ID = $($cred.UserName);Password = $($cred.GetNetworkCredential().password);"
        } else {
            Write-Verbose 'Setting SQL to use SSPI'
            $connectionString = "Data Source=$ServerInstance;Integrated Security=true;Initial Catalog=master;Connect Timeout=3;"
        }

        $sqlConn = New-Object ("Data.SqlClient.SqlConnection") $connectionString
        trap {
            Write-Error "Cannot connect to $Server.";
            exit
        }

        $sqlConn.Open()
        if ($sqlConn.State -eq 'Open') {
            Write-Verbose "Successfully connected to $ServerInstance"
            $sqlConn.Close()
        }
    }

    End{}
}