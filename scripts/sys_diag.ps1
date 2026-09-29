
# ====================================================
# COMPUTER PULSE - SYSTEM DIAGNOSTIC AGENT (POWERSHELL)
# ====================================================
$LogFile = "data\system_init.log"
Write-Host "[PROCESSING] Gathering system statistics..." -ForegroundColor Cyan
# INPUT: Query system information via native PowerShell CIM cmdlets
$os = Get-CimInstance -ClassName Win32_OperatingSystem
# PROCESSING: Convert memory metrics from Kilobytes to Megabytes
$totalRamMB = [math]::Round($os.TotalVisibleMemorySize / 1024, 2)
$freeRamMB = [math]::Round($os.FreePhysicalMemory / 1024, 2)
$timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$computerName = $env:COMPUTERNAME
$userName = $env:USERNAME
# Construct formatted multiline output string
$logContent = @"
====================================================
 COMPUTER PULSE SYSTEM LOG
====================================================
Generated On : $timeStamp
Hostname : $computerName
User Account : $userName
----------------------------------------------------
OS Specifications:
OS Name : $($os.Caption)
OS Version : $($os.Version)
System Type : $($os.OSArchitecture)
----------------------------------------------------
Memory & Hardware Status:
Total Memory : $totalRamMB MB
Free Memory : $freeRamMB MB
====================================================
"@