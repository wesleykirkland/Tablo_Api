function Remove-MSSQLConnection {
    #Params
    [CmdletBinding()]
    Param(
    [parameter(Position=0,Mandatory=$true)]
        $SQLConnection
    )

    Process {
        Try {
            $SQLConnection.Close()
            $SQLConnection.Dispose()
        } Catch {
            Write-Warning 'Unable to close SQLConnection'
        }
    }
}