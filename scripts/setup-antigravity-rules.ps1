# Antigravity ルールセットアップ（Windows用）
# 管理者権限で実行してください

$dotfilesPath = "$env:USERPROFILE\Dotfiles\.gemini"
$geminiPath = "$env:USERPROFILE\.gemini"

Write-Host "🔧 Antigravity ルールをセットアップします..." -ForegroundColor Cyan

# ルールディレクトリを作成
if (-not (Test-Path "$geminiPath\rules")) {
    New-Item -ItemType Directory -Path "$geminiPath\rules" -Force | Out-Null
}

# ワークフローディレクトリを作成
if (-not (Test-Path "$geminiPath\antigravity\workflows")) {
    New-Item -ItemType Directory -Path "$geminiPath\antigravity\workflows" -Force | Out-Null
}

# ファイルをコピー
Write-Host "📄 rules.md をコピー..." -ForegroundColor Yellow
Copy-Item "$dotfilesPath\rules.md" "$geminiPath\rules.md" -Force

Write-Host "📁 rules/ をコピー..." -ForegroundColor Yellow
Copy-Item "$dotfilesPath\rules\*" "$geminiPath\rules\" -Force

Write-Host "📁 workflows/ をコピー..." -ForegroundColor Yellow
Copy-Item "$dotfilesPath\antigravity\workflows\*" "$geminiPath\antigravity\workflows\" -Force

Write-Host ""
Write-Host "✅ セットアップ完了！" -ForegroundColor Green
Write-Host ""
Write-Host "以下のスラッシュコマンドが使えます:" -ForegroundColor Cyan
Write-Host "  /dev      - 開発モード" -ForegroundColor White
Write-Host "  /docs     - ドキュメント作成モード" -ForegroundColor White
Write-Host "  /research - リサーチモード" -ForegroundColor White
