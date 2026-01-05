# Dotfiles セットアップスクリプト (Windows PowerShell)
# シンボリックリンクを作成するため、管理者権限または開発者モードが必要です

param(
    [switch]$Force  # 既存のファイルを上書きする場合
)

$ErrorActionPreference = "Stop"

# パス設定
$DotfilesDir = $PSScriptRoot
$RulesSource = Join-Path $DotfilesDir ".gemini\rules.md"
$GeminiTarget = Join-Path $env:USERPROFILE ".gemini"
$RulesTarget = Join-Path $GeminiTarget "rules.md"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Dotfiles セットアップ (Windows)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Dotfiles: $DotfilesDir"
Write-Host "Source:   $RulesSource"
Write-Host "Target:   $RulesTarget"
Write-Host ""

# 管理者権限チェック
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "注意: 管理者権限がありません。開発者モードが無効の場合、失敗する可能性があります。" -ForegroundColor Yellow
    Write-Host ""
}

# .gemini ディレクトリの確認・作成
Write-Host "[1/3] .gemini ディレクトリを確認中..." -ForegroundColor Green

if (-not (Test-Path $GeminiTarget)) {
    New-Item -ItemType Directory -Path $GeminiTarget | Out-Null
    Write-Host "  .gemini ディレクトリを作成しました" -ForegroundColor Green
} else {
    Write-Host "  .gemini ディレクトリは既に存在します" -ForegroundColor Gray
}

# rules.md のセットアップ
Write-Host ""
Write-Host "[2/3] rules.md をセットアップ中..." -ForegroundColor Green

if (Test-Path $RulesTarget) {
    $item = Get-Item $RulesTarget -Force
    if ($item.LinkType -eq "SymbolicLink") {
        Write-Host "  既にシンボリックリンクが設定されています" -ForegroundColor Gray
    } else {
        if ($Force) {
            Write-Host "  既存の rules.md を削除します..." -ForegroundColor Yellow
            Remove-Item -Path $RulesTarget -Force
        } else {
            Write-Host "  既存の rules.md をバックアップします..." -ForegroundColor Yellow
            $backupPath = "${RulesTarget}.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
            Move-Item -Path $RulesTarget -Destination $backupPath
            Write-Host "  バックアップ: $backupPath" -ForegroundColor Gray
        }
    }
}

if (-not (Test-Path $RulesTarget)) {
    try {
        New-Item -ItemType SymbolicLink -Path $RulesTarget -Target $RulesSource | Out-Null
        Write-Host "  シンボリックリンクを作成しました:" -ForegroundColor Green
        Write-Host "    $RulesTarget -> $RulesSource" -ForegroundColor Gray
    } catch {
        Write-Host "  エラー: シンボリックリンクの作成に失敗しました。" -ForegroundColor Red
        Write-Host "  以下のいずれかをお試しください:" -ForegroundColor Yellow
        Write-Host "    1. 管理者として PowerShell を実行" -ForegroundColor Yellow
        Write-Host "    2. 設定 > システム > 開発者向け > 開発者モード を有効化" -ForegroundColor Yellow
        exit 1
    }
}

# 確認
Write-Host ""
Write-Host "[3/3] セットアップを確認中..." -ForegroundColor Green

if (Test-Path $RulesTarget) {
    $content = Get-Content $RulesTarget -First 1
    if ($content -match "CRITICAL PROTOCOLS") {
        Write-Host "  ✅ rules.md が正しくリンクされています" -ForegroundColor Green
    } else {
        Write-Host "  ⚠️ rules.md は存在しますが、内容が異なる可能性があります" -ForegroundColor Yellow
    }
} else {
    Write-Host "  ❌ rules.md が見つかりません" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  セットアップ完了！" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Antigravityを再起動すると、新しいルールが適用されます。"
