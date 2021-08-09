<#
Title: PowerShell Transcription Retention Policy Script

Author: Levi Wilkerson
Date: 2021 August, 09
Version: 1.0


Description: Script is used to delete uneccessary transcription files after
 retention policy time period to a specified folder.
#>

# Known issue: Running in text editor (VSCode) produces error.

### DEFINE VARIABLES
$retentionFullPath = "C:\PSTranscriptionTest\"
$retentionPeriodDays = 4

### SCRIPT START
if (!(Test-path $retentionFullPath)) {
  Write-Error "Path doesn't exist! Please verify folder directory and try again."
  exit
}
$items = Get-ChildItem -Path $retentionFullPath -recurse | Where-Object {!$_.PSIsContainer -AND $_.lastwritetime -lt (get-date).addDays(-$retentionPeriodDays)}
$itemsCount = $items.Length
$items | Remove-Item -Verbose
write-host "Removed $itemsCount items from $retentionFullPath and daughter folders." -ForegroundColor Green -BackgroundColor Black

exit