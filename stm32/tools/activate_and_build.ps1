param([Parameter(Mandatory=$true)][ValidateSet("task5","task6","task7")][string]$Task)
$ErrorActionPreference="Stop"
$repo=Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$project="C:\Users\young\Documents\ece2_474"
$map=@{task5="task5_pc_echo";task6="task6_mcu_to_fpga";task7="task7_uart_led"}
$src=Join-Path $repo ("stm32\"+$map[$Task]+"\ece2_474_routine.c")
$dst=Join-Path $project "Core\Src\ece2_474_routine.c"
$backup=Join-Path $project ("lab6_backup\"+(Get-Date -Format "yyyyMMdd-HHmmss")+"_before_"+$Task)
New-Item -ItemType Directory -Force -Path $backup|Out-Null
Copy-Item -LiteralPath $dst -Destination (Join-Path $backup "ece2_474_routine.c")
Copy-Item -LiteralPath $src -Destination $dst -Force
$ninja="C:\Users\young\AppData\Local\stm32cube\bundles\ninja\1.13.2+st.1\bin\ninja.exe"
if(-not (Test-Path -LiteralPath $ninja)){throw "STM32Cube Ninja not found: $ninja"}
& $ninja -C (Join-Path $project "build\Debug") -t clean
if($LASTEXITCODE -ne 0){throw "ARM clean failed: exit $LASTEXITCODE"}
& $ninja -C (Join-Path $project "build\Debug")
if($LASTEXITCODE -ne 0){throw "ARM build failed: exit $LASTEXITCODE"}
Write-Host "ACTIVE $Task; backup=$backup"
