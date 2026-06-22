# sync_html.ps1 — Windows 版 html 清單同步工具（對應 sync_html.sh）
# 用法：powershell -ExecutionPolicy Bypass -File .\sync_html.ps1
# 請在專案根目錄執行；腳本會自動切換至自身所在目錄。

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Set-Location $PSScriptRoot

$MD = '1.md'
$IgnoreFile = '.html.ignore'

function Test-InIgnore {
    param([string]$FileName)
    if (-not (Test-Path -LiteralPath $IgnoreFile)) { return $false }
    $lines = Get-Content -LiteralPath $IgnoreFile -Encoding UTF8
    foreach ($line in $lines) {
        if ($line -ceq $FileName) { return $true }
    }
    return $false
}

function Test-InMarkdown {
    param([string]$FileName)
    $pattern = "(./$FileName)"
    $content = Get-Content -LiteralPath $MD -Raw -Encoding UTF8
    return $content.Contains($pattern)
}

function Write-Utf8NoBomLines {
    param(
        [string]$Path,
        [string[]]$Lines
    )
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    $text = ($Lines -join "`n")
    if ($Lines.Count -gt 0) { $text += "`n" }
    [System.IO.File]::WriteAllText($Path, $text, $utf8NoBom)
}

function Add-ToolToSection {
    param(
        [string]$Section,
        [string]$ToolName,
        [string]$FileName
    )
    $sectionHeader = "## $Section"
    $toolLine = "* [$ToolName](./$FileName)"
    $newLines = @()
    foreach ($row in Get-Content -LiteralPath $MD -Encoding UTF8) {
        $newLines += $row
        if ($row -ceq $sectionHeader) {
            $newLines += $toolLine
        }
    }
    Write-Utf8NoBomLines -Path $MD -Lines $newLines
}

# 與 bash 相同：grep '^## ' | sed 's/^## //'
$sections = @(
    Get-Content -LiteralPath $MD -Encoding UTF8 |
        Where-Object { $_ -match '^## ' } |
        ForEach-Object { $_ -replace '^## ', '' }
)

$htmlFiles = @(Get-ChildItem -Path . -Filter '*.html' -File | ForEach-Object { $_.Name })
$pending = @()

foreach ($f in $htmlFiles) {
    if (Test-InIgnore -FileName $f) { continue }
    if (Test-InMarkdown -FileName $f) { continue }
    $pending += $f
}

Write-Host '=== html 清單同步工具 (sync_html.ps1) ==='
Write-Host "掃描 $($htmlFiles.Count) 個 html 檔"

if ($pending.Count -eq 0) {
    Write-Host ''
    Write-Host '沒有發現新的 html 檔案（皆已收錄於 1.md 或列於 .html.ignore）。'
    Write-Host '若要重新處理某檔案，請從 1.md 或 .html.ignore 移除對應項目後再執行。'
    exit 0
}

Write-Host "待處理 $($pending.Count) 個：$($pending -join ', ')"
Write-Host ''

foreach ($f in $pending) {
    Write-Host "發現新 html：$f"
    Write-Host '可用段落：'
    $i = 1
    foreach ($s in $sections) {
        Write-Host " $i) $s"
        $i++
    }
    Write-Host ''

    $idx = Read-Host '加到哪個段落 1,2,3... (x=跳過, xx=忽略, 預設 others)'

    switch ($idx) {
        'x' {
            Write-Host "跳過 $f"
            Write-Host ''
            continue
        }
        'xx' {
            $utf8NoBom = New-Object System.Text.UTF8Encoding $false
            [System.IO.File]::AppendAllText($IgnoreFile, "$f`n", $utf8NoBom)
            Write-Host "已加入 ignore：$f"
            Write-Host ''
            continue
        }
    }

    $name = Read-Host "小工具名稱($f)"
    if ([string]::IsNullOrEmpty($name)) {
        $toolName = [System.IO.Path]::GetFileNameWithoutExtension($f)
    }
    else {
        $toolName = $name
    }

    if ([string]::IsNullOrEmpty($idx)) {
        $section = 'others'
    }
    else {
        if ($idx -notmatch '^\d+$' -or [int]$idx -lt 1 -or [int]$idx -gt $sections.Count) {
            Write-Host "無效的段落編號：$idx（請輸入 1–$($sections.Count)）" -ForegroundColor Yellow
            Write-Host ''
            continue
        }
        $sectionIndex = [int]$idx - 1
        $section = $sections[$sectionIndex]
    }

    Add-ToolToSection -Section $section -ToolName $toolName -FileName $f

    Write-Host "已加入 ## $section"
    Write-Host ''
}

Write-Host '=== 完成 ==='
