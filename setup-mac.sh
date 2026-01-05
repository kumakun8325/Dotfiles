#!/bin/bash
# Dotfiles セットアップスクリプト (macOS/Linux)

set -e

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# パス設定
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
RULES_SOURCE="$DOTFILES_DIR/.gemini/rules.md"
GEMINI_TARGET="$HOME/.gemini"
RULES_TARGET="$GEMINI_TARGET/rules.md"

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  Dotfiles セットアップ (macOS/Linux)${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo "Dotfiles: $DOTFILES_DIR"
echo "Source:   $RULES_SOURCE"
echo "Target:   $RULES_TARGET"
echo ""

# .gemini ディレクトリの確認・作成
echo -e "${GREEN}[1/3] .gemini ディレクトリを確認中...${NC}"

if [ ! -d "$GEMINI_TARGET" ]; then
    mkdir -p "$GEMINI_TARGET"
    echo -e "  ${GREEN}.gemini ディレクトリを作成しました${NC}"
else
    echo -e "  ${GRAY}.gemini ディレクトリは既に存在します${NC}"
fi

# rules.md のセットアップ
echo ""
echo -e "${GREEN}[2/3] rules.md をセットアップ中...${NC}"

if [ -e "$RULES_TARGET" ]; then
    if [ -L "$RULES_TARGET" ]; then
        echo -e "  ${GRAY}既にシンボリックリンクが設定されています${NC}"
    else
        echo -e "${YELLOW}  既存の rules.md をバックアップします...${NC}"
        BACKUP_PATH="${RULES_TARGET}.backup_$(date +%Y%m%d_%H%M%S)"
        mv "$RULES_TARGET" "$BACKUP_PATH"
        echo -e "  ${GRAY}バックアップ: $BACKUP_PATH${NC}"
    fi
fi

if [ ! -e "$RULES_TARGET" ]; then
    ln -s "$RULES_SOURCE" "$RULES_TARGET"
    echo -e "  ${GREEN}シンボリックリンクを作成しました:${NC}"
    echo -e "    ${GRAY}$RULES_TARGET -> $RULES_SOURCE${NC}"
fi

# 確認
echo ""
echo -e "${GREEN}[3/3] セットアップを確認中...${NC}"

if [ -f "$RULES_TARGET" ]; then
    if head -n 1 "$RULES_TARGET" | grep -q "CRITICAL PROTOCOLS"; then
        echo -e "  ${GREEN}✅ rules.md が正しくリンクされています${NC}"
    else
        echo -e "  ${YELLOW}⚠️ rules.md は存在しますが、内容が異なる可能性があります${NC}"
    fi
else
    echo -e "  ${RED}❌ rules.md が見つかりません${NC}"
fi

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  セットアップ完了！${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo "Antigravityを再起動すると、新しいルールが適用されます。"
