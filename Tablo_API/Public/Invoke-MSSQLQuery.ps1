function Invoke-MSSQLQuery {
    #Params
    [CmdletBinding()]
    Param(
    [parameter(Position=0,Mandatory=$true)]
        $SQLConnection,
    [parameter(Position=1,Mandatory=$true)]
        $Query
    )

    Process {
        if ($SQLConnection.State -ne [Data.ConnectionState]::Open) {
            Write-Output "Connection to SQL DB not open"
        } else {
            $SqlCmd = New-Object System.Data.SqlClient.SqlCommand 
            $SqlCmd.Connection = $SqlConnection 
            $SqlCmd.CommandText = $Query 
            $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter 
            $SqlAdapter.SelectCommand = $SqlCmd 
            $DataSet = New-Object System.Data.DataSet 
            $a=$SqlAdapter.Fill($DataSet) 
            $DataSet.Tables[0]
        }
    }
}