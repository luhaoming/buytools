@echo off
setlocal enabledelayedexpansion

:: 1. 管理員權限檢查
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please right-click and "Run as Administrator"!
    pause
    exit /b
)

:: 2. 自動偵測目前目錄
set "workDir=%~dp0"
set "workDir=%workDir:~0,-1%"
set "ps1File=%workDir%\Fix_CSVExcel.ps1"
set "sendToDir=%AppData%\Microsoft\Windows\SendTo"
set "lnkName=Fix_CSVExcel.lnk"

echo [Checking] Workspace: %workDir%

:: 3. 產出「防呆+備份版」PS1
echo [System] Generating %ps1File%...
(
echo foreach ^($file in $args^) {
echo     if ^(Test-Path $file^) {
echo         $bytes = Get-Content -LiteralPath $file -Encoding Byte -TotalCount 3
echo         $hex = ^($bytes ^| ForEach-Object { "{0:X2}" -f $_ }^) -join " "
echo         if ^($hex -eq "EF BB BF"^) {
echo             Write-Host "Skip: $file ^(Already has BOM^)" -ForegroundColor Yellow
echo             continue
echo         }
echo         $backup = "$file.bak"
echo         if ^(-not ^(Test-Path $backup^)^) {
echo             Copy-Item -LiteralPath $file -Destination $backup -Force
echo             Write-Host "Backup created: $backup"
echo         }
echo         try {
echo             $content = [System.IO.File]::ReadAllText^($file, [System.Text.Encoding]::UTF8^)
echo             [System.IO.File]::WriteAllText^($file, $content, [System.Text.Encoding]::UTF8^)
echo             Write-Host "Success: $file ^(BOM added^)" -ForegroundColor Green
echo         } catch {
echo             Write-Host "Error: $_" -ForegroundColor Red
echo         }
echo     }
echo }
) > "%ps1File%"

:: 4. 開啟 PowerShell 執行權限
powershell -NoProfile -Command "Set-ExecutionPolicy RemoteSigned -Force"

:: 5. 建立右鍵傳送到捷徑 (指向偵測到的目錄)
set "vbsFile=%temp%\CreateShortcut.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%vbsFile%"
echo sLinkFile = "%sendToDir%\%lnkName%" >> "%vbsFile%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%vbsFile%"
echo oLink.TargetPath = "powershell.exe" >> "%vbsFile%"
echo oLink.Arguments = "-NoProfile -ExecutionPolicy Bypass -File ""%ps1File%""" >> "%vbsFile%"
echo oLink.IconLocation = "powershell.exe,0" >> "%vbsFile%"
echo oLink.Save >> "%vbsFile%"
cscript /nologo "%vbsFile%"
del "%vbsFile%"

echo ==========================================
echo [OK] Fix_CSVExcel Installed!
echo Directory: %workDir%
echo Action: Right-click -^> Send to -^> Fix_CSVExcel
echo ==========================================
pause