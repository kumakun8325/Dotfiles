# 🔧 Dotfiles

個人開発環境の設定ファイルを管理するリポジトリです。

## 📁 構成

```
Dotfiles/
├── .gemini/
│   └── rules.md          # Antigravity グローバルルール
├── setup-windows.ps1     # Windows セットアップスクリプト
├── setup-mac.sh          # macOS/Linux セットアップスクリプト
└── README.md             # このファイル
```

## 🚀 セットアップ

### 前提条件

- Git がインストールされていること
- Antigravity (VS Code拡張) がインストールされていること

### Windows

1. リポジトリをクローン:
   ```powershell
   git clone https://github.com/kumakun8325/Dotfiles.git $env:USERPROFILE\Dotfiles
   ```

2. **管理者権限**で PowerShell を開き、セットアップスクリプトを実行:
   ```powershell
   cd $env:USERPROFILE\Dotfiles
   .\setup-windows.ps1
   ```

   または、開発者モードを有効にしている場合は管理者権限不要:
   - 設定 > 更新とセキュリティ > 開発者向け > 開発者モード

### macOS / Linux

1. リポジトリをクローン:
   ```bash
   git clone https://github.com/kumakun8325/Dotfiles.git ~/Dotfiles
   ```

2. セットアップスクリプトを実行:
   ```bash
   cd ~/Dotfiles
   chmod +x setup-mac.sh
   ./setup-mac.sh
   ```

## 📋 含まれる設定

### Antigravity グローバルルール (`.gemini/rules.md`)

すべてのプロジェクトに適用される共通ルール:

1. **ブランチ強制** - main/master/developでの直接作業禁止
2. **日本語化** - 成果物はすべて日本語
3. **品質保証** - Lint/テスト実行後に報告
4. **既存テストの保護** - テスト失敗時は実装を疑う
5. **機密情報の保護** - APIキー等を出力しない
6. **ドキュメントの同期** - コード変更時にドキュメントも更新
7. **自動化の限界と報告** - 複数回失敗時は報告
8. **不要リソースの削除** - 一時ファイル/ブランチの削除
9. **作業中断時のロールバック** - 不安定な状態を残さない

## 🔄 ルールの更新

1. このリポジトリの `.gemini/rules.md` を編集
2. 変更をコミット & プッシュ:
   ```bash
   git add .gemini/rules.md
   git commit -m "ルールを更新"
   git push
   ```
3. 他のマシンで `git pull` して同期

## 🔗 関連リンク

- [参考記事: Antigravityの設定をGeminiに聞いてみた](https://zenn.dev/ken1141/articles/4a8810343e5c07)

## 📝 ライセンス

個人利用のための設定ファイルです。
