function GetAppsByServer{
    Clear-Host
    $ServerName = Read-Host "Input Target Server Name"
    $check
    $wg = (Get-XAWorkerGroup -ServerName $ServerName).workergroupname

    "======== $ServerName DATA RESULTS ======== `r`n"  | Out-File .\Output\AppsByServerResult.txt
    "WorkerGroups Found:" | Out-File -Append .\Output\AppsByServerResult.txt
    $wg | Out-File -Append .\Output\AppsByServerResult.txt

    foreach ($w in $wg){
        "`r`n-------- $w --------"  | Out-File -Append .\Output\AppsByServerResult.txt
        $check = Get-XAApplication -WorkerGroupName $w | Where-Object {$_.Enabled -eq "True"} | Select-Object DisplayName, BrowserName  | Sort-Object DisplayName 
        if($check){
            $check | Out-File -Append .\Output\AppsByServerResult.txt
        } else {
        "NO APPS Provided`n" | Out-File -Append .\Output\AppsByServerResult.txt
        }
        
    }
    
    "`r`n-------- NOT WorkerGroup Provided -------- `r`n"  | Out-File -Append .\Output\AppsByServerResult.txt
    Get-XAApplication -ServerName $ServerName | Where-Object {$_.Enabled -eq "True"} | Select-Object DisplayName, BrowserName | Sort-Object DisplayName | Format-Table -AutoSize| Out-File -Append .\Output\AppsByServerResult.txt
    Invoke-Item .\Output\AppsByServerResult.txt
}

GetAppsByServer

