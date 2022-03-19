$worker_group_name = Read-Host "Worker Group Name:"

$servers = (Get-XAWorkerGroup -WorkerGroupName $worker_group_name).servernames | Sort-Object

$servers | ForEach-Object {

    $session = (Get-XASession -ServerName $_ | Where-Object {$_.State -eq "Active" -and $_.Protocol -eq "Ica"}).count
    $logon = (Get-XAServer -ServerName $_).logonMode

    Write-Host "$_ - $session - $logon"
    
}
