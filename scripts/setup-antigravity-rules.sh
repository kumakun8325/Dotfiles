#!/bin/bash
# Antigravity ルールセットアップ（Mac/Linux用）

DOTFILES_PATH="$HOME/Dotfiles/.gemini"
GEMINI_PATH="$HOME/.gemini"

echo "🔧 Antigravity ルールをセットアップします..."

# ルールディレクトリを作成
mkdir -p "$GEMINI_PATH/rules"
mkdir -p "$GEMINI_PATH/antigravity/workflows"

# ファイルをコピー
echo "📄 rules.md をコピー..."
cp "$DOTFILES_PATH/rules.md" "$GEMINI_PATH/rules.md"

echo "📁 rules/ をコピー..."
cp "$DOTFILES_PATH/rules/"* "$GEMINI_PATH/rules/"

echo "📁 workflows/ をコピー..."
cp "$DOTFILES_PATH/antigravity/workflows/"* "$GEMINI_PATH/antigravity/workflows/"

echo ""
echo "✅ セットアップ完了！"
echo ""
echo "以下のスラッシュコマンドが使えます:"
echo "  /dev      - 開発モード"
echo "  /docs     - ドキュメント作成モード"
echo "  /research - リサーチモード"
