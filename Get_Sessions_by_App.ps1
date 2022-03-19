$worker_group_name = Read-Host "Worker Group Name:"
$servers = (Get-XAWorkerGroup -WorkerGroupName $worker_group_name).Servernames | Sort-Object
$zero = @()
$ses = @()

$servers | ForEach-Object {
    
    $sessions = (Get-XASession -ServerName $_ | Where-Object {$_.State -eq "Active" -and $_.Protocol -eq "Ica"} ).count 
    Write-Host "$_ -- $sessions"
    $ses += $sessions
    if($sessions -eq 0){ $zero += $_ }
    #test-path "\\$_\C$\Program Files (x86)\Adobe\Acrobat Reader 2015\Reader\AcroRd32.exe"
}