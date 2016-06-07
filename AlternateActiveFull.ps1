﻿$Jobs = get-vbrjob |Where-Object {$_.JobType -eq "Backup"}

$patterns = @(
    ("January","April","July","October"),
    ("February","May","August","November"),
    ("March","June","September","December")
)

$i=0

foreach ($j in $Jobs) {
    $j.Name

    $o = $j.GetOptions()

    # Uncomment this line to actually enable active full backups
    # $o.BackupStorageOptions.EnableFullBackup = $true

    $o.BackupTargetOptions.FullBackupScheduleKind = "Monthly"

    $o.BackupTargetOptions.FullBackupMonthlyScheduleOptions.DayNumberInMonth = "First"
    $o.BackupTargetOptions.FullBackupMonthlyScheduleOptions.DayOfWeek = "Saturday"
    $o.BackupTargetOptions.FullBackupMonthlyScheduleOptions.Months = $patterns[$i]
    
    $o = Set-VBRJobOptions -Job $j -Options $o
    
    if ($i -eq 2) {
        $i=0
    } else {
        $i++
    }
}