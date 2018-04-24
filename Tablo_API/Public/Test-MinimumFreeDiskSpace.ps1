Function Test-MinimumFreeDiskSpace {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidatePattern('[A-Z]')]
        [string]$DiskDrive,

        [Parameter(Mandatory=$true)]
        [ValidateRange(1,99)]
        [int]$DiskMinimumFreePercentage = 10
    )

    Begin {
        Write-Verbose 'Checking for free disk space'
    }

    Process {
        $DriveObject = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID like '$($DiskDrive)%'"
        $IsBelowMinimumDiskSpace = if ($DriveObject.FreeSpace -lt ($DriveObject.Size * ($($DiskMinimumFreePercentage / 100)))) {
           $true
        }
    }

    End {
        if ($IsBelowMinimumDiskSpace) {
            throw "Not enough disk space on $DiskDrive"
        }
    }
}