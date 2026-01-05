# Dotfiles セットアップスクリプト (Windows PowerShell)
# 管理者権限で実行してください

param(
    [switch]$Force  # 既存のファイルを上書きする場合
)

$ErrorActionPreference = "Stop"

# パス設定
$DotfilesDir = $PSScriptRoot
$GeminiSource = Join-Path $DotfilesDir ".gemini"
$GeminiTarget = Join-Path $env:USERPROFILE ".gemini"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Dotfiles セットアップ (Windows)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Dotfiles: $DotfilesDir"
Write-Host "Target:   $GeminiTarget"
Write-Host ""

# 管理者権限チェック
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "警告: 管理者権限がありません。シンボリックリンクの作成に失敗する可能性があります。" -ForegroundColor Yellow
    Write-Host "管理者として PowerShell を再起動してください。" -ForegroundColor Yellow
    Write-Host ""
}

# .gemini ディレクトリのセットアップ
Write-Host "[1/2] .gemini ディレクトリをセットアップ中..." -ForegroundColor Green

if (Test-Path $GeminiTarget) {
    if ($Force) {
        Write-Host "  既存の .gemini を削除します..." -ForegroundColor Yellow
        Remove-Item -Path $GeminiTarget -Recurse -Force
    } else {
        # 既存がシンボリックリンクかチェック
        $item = Get-Item $GeminiTarget -Force
        if ($item.LinkType -eq "SymbolicLink") {
            Write-Host "  既にシンボリックリンクが設定されています。スキップします。" -ForegroundColor Gray
        } else {
            Write-Host "  既存の .gemini フォルダがあります。バックアップを作成します..." -ForegroundColor Yellow
            $backupPath = "${GeminiTarget}_backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
            Move-Item -Path $GeminiTarget -Destination $backupPath
            Write-Host "  バックアップ: $backupPath" -ForegroundColor Gray
        }
    }
}

if (-not (Test-Path $GeminiTarget)) {
    try {
        New-Item -ItemType SymbolicLink -Path $GeminiTarget -Target $GeminiSource | Out-Null
        Write-Host "  シンボリックリンクを作成しました: $GeminiTarget -> $GeminiSource" -ForegroundColor Green
    } catch {
        Write-Host "  エラー: シンボリックリンクの作成に失敗しました。" -ForegroundColor Red
        Write-Host "  管理者権限で実行するか、開発者モードを有効にしてください。" -ForegroundColor Red
        Write-Host "  設定 > 更新とセキュリティ > 開発者向け > 開発者モード" -ForegroundColor Yellow
        exit 1
    }
}

# 確認
Write-Host ""
Write-Host "[2/2] セットアップを確認中..." -ForegroundColor Green

if (Test-Path (Join-Path $GeminiTarget "rules.md")) {
    Write-Host "  ✅ rules.md が正しくリンクされています" -ForegroundColor Green
} else {
    Write-Host "  ❌ rules.md が見つかりません" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  セットアップ完了！" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Antigravityを再起動すると、新しいルールが適用されます。"
