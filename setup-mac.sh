#!/bin/bash
# Dotfiles セットアップスクリプト (macOS/Linux)

set -e

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# パス設定
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
GEMINI_SOURCE="$DOTFILES_DIR/.gemini"
GEMINI_TARGET="$HOME/.gemini"

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  Dotfiles セットアップ (macOS/Linux)${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo "Dotfiles: $DOTFILES_DIR"
echo "Target:   $GEMINI_TARGET"
echo ""

# .gemini ディレクトリのセットアップ
echo -e "${GREEN}[1/2] .gemini ディレクトリをセットアップ中...${NC}"

if [ -e "$GEMINI_TARGET" ]; then
    if [ -L "$GEMINI_TARGET" ]; then
        echo "  既にシンボリックリンクが設定されています。スキップします。"
    else
        echo -e "${YELLOW}  既存の .gemini フォルダがあります。バックアップを作成します...${NC}"
        BACKUP_PATH="${GEMINI_TARGET}_backup_$(date +%Y%m%d_%H%M%S)"
        mv "$GEMINI_TARGET" "$BACKUP_PATH"
        echo "  バックアップ: $BACKUP_PATH"
    fi
fi

if [ ! -e "$GEMINI_TARGET" ]; then
    ln -s "$GEMINI_SOURCE" "$GEMINI_TARGET"
    echo -e "${GREEN}  シンボリックリンクを作成しました: $GEMINI_TARGET -> $GEMINI_SOURCE${NC}"
fi

# 確認
echo ""
echo -e "${GREEN}[2/2] セットアップを確認中...${NC}"

if [ -f "$GEMINI_TARGET/rules.md" ]; then
    echo -e "  ${GREEN}✅ rules.md が正しくリンクされています${NC}"
else
    echo -e "  ${RED}❌ rules.md が見つかりません${NC}"
fi

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  セットアップ完了！${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo "Antigravityを再起動すると、新しいルールが適用されます。"
