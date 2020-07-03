$properties = @(
    @{Name = "Name"; Expression = { $_.name } },
    @{Name = "PID"; Expression = { $_.IDProcess } },
    @{Name = "CPU (%)"; Expression = { $_.PercentProcessorTime } },
    @{Name = "Memory (MB)"; Expression = { [Math]::Round(($_.workingSetPrivate / 1mb), 2) } }
    @{Name = "Disk (MB)"; Expression = { [Math]::Round(($_.IODataOperationsPersec / 1mb), 2) } }
)
$ProcessCPU = Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process |
Select-Object $properties |
Sort-Object "CPU (%)" -desc |
Select-Object -First 5
$ProcessCPU | select *, @{Name = "Path"; Expression = { (Get-Process -Id $_.PID).Path } } | Format-Table



$properties=@(
    @{Name="Name"; Expression = {$_.name}},
    @{Name="PID"; Expression = {$_.IDProcess}},
    @{Name="CPU (%)"; Expression = {$_.PercentProcessorTime}},
    @{Name="Memory (MB)"; Expression = {[Math]::Round(($_.workingSetPrivate / 1mb),2)}}
    @{Name="Disk (MB)"; Expression = {[Math]::Round(($_.IODataOperationsPersec / 1mb),2)}}
    @{Name="Path";Expression = {(Get-Process -Id $_.IDProcess).Path}}
)
$ProcessCPU = Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process |
    Select-Object $properties |
    Sort-Object "CPU (%)" -desc |
    Select-Object -First 5 |
    Format-Table -AutoSize
    $ProcessCPU



###################################################
Function Get-CPUProcess { 
    $properties = @(
        @{Name = "Name"; Expression = { $_.name } },
        @{Name = "PID"; Expression = { $_.IDProcess } },
        @{Name = "CPU (%)"; Expression = { $_.PercentProcessorTime } },
        @{Name = "Memory (MB)"; Expression = { [Math]::Round(($_.workingSetPrivate / 1mb), 2) } }
        @{Name = "Disk (MB)"; Expression = { [Math]::Round(($_.IODataOperationsPersec / 1mb), 2) } }
        @{Name = "Path"; Expression = { (Get-Process -Id $_.IDProcess).Path } }
    )
$ProcessCPU = Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process |
Select-Object $properties |
Sort-Object "CPU (%)" -desc |
Select-Object -First 5 |
Format-Table -AutoSize
$ProcessCPU
}
Get-CPUProcess -Filter { processname -like "firefox*" } | select * 
#| Out-File C:\filename.txt
#powershell