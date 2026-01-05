# 🔧 Dotfiles

個人開発環境の設定ファイルを管理するリポジトリです。
複数のマシン（Windows / Mac）で同じ開発環境を維持するために使用します。

## 📁 構成

```
Dotfiles/
├── .gemini/
│   └── rules.md          # Antigravity グローバルルール
├── setup-windows.ps1     # Windows セットアップスクリプト
├── setup-mac.sh          # macOS/Linux セットアップスクリプト
├── .gitignore            # Git除外設定
└── README.md             # このファイル
```

---

## 🚀 初回セットアップ

### 前提条件

- Git がインストールされていること
- Antigravity (VS Code拡張) がインストールされていること

---

### Windows セットアップ

#### Step 1: リポジトリをクローン

PowerShell を開いて実行:

```powershell
git clone https://github.com/kumakun8325/Dotfiles.git C:\Users\$env:USERNAME\Dotfiles
```

#### Step 2: セットアップスクリプトを実行

**管理者権限で PowerShell を開いて**実行:

```powershell
cd C:\Users\$env:USERNAME\Dotfiles
powershell -ExecutionPolicy Bypass -File .\setup-windows.ps1
```

> **注意**: 「スクリプトの実行が無効」エラーが出た場合は、`-ExecutionPolicy Bypass` オプションを付けてください。

#### Step 3: Antigravityを再起動

VS Code を再起動すると、新しいルールが適用されます。

---

### macOS / Linux セットアップ

#### Step 1: リポジトリをクローン

ターミナルを開いて実行:

```bash
git clone https://github.com/kumakun8325/Dotfiles.git ~/Dotfiles
```

#### Step 2: セットアップスクリプトを実行

```bash
cd ~/Dotfiles
chmod +x setup-mac.sh
./setup-mac.sh
```

#### Step 3: Antigravityを再起動

VS Code を再起動すると、新しいルールが適用されます。

---

## 🔄 ルールの変更手順

### ルールを編集する

1. **このリポジトリをpullして最新化**:
   ```bash
   cd ~/Dotfiles  # または C:\Users\<ユーザー名>\Dotfiles
   git pull
   ```

2. **`.gemini/rules.md` を編集**:
   - お好みのエディタで開く
   - ルールを追加・変更・削除

3. **変更をコミット & プッシュ**:
   ```bash
   git add .gemini/rules.md
   git commit -m "ルールを更新: [変更内容の簡単な説明]"
   git push
   ```

### 他のマシンで同期する

他のマシンでルールを最新化するには:

```bash
cd ~/Dotfiles  # または C:\Users\<ユーザー名>\Dotfiles
git pull
```

> **Note**: シンボリックリンクを使用しているため、`git pull` するだけで自動的に `~/.gemini/rules.md` も更新されます。

---

## 📋 含まれる設定

### Antigravity グローバルルール (`.gemini/rules.md`)

すべてのプロジェクトに適用される共通ルール:

| # | ルール | 説明 |
|---|--------|------|
| 1 | **ブランチ強制** | main/master/developでの直接作業禁止 |
| 2 | **日本語化** | 成果物はすべて日本語で記述 |
| 3 | **品質保証** | Lint/テスト実行後に報告 |
| 4 | **既存テストの保護** | テスト失敗時は実装のバグを疑う |
| 5 | **機密情報の保護** | APIキー等を出力しない |
| 6 | **ドキュメントの同期** | コード変更時にドキュメントも更新 |
| 7 | **自動化の限界と報告** | 複数回失敗時は即座に報告 |
| 8 | **不要リソースの削除** | 一時ファイル/ブランチの削除 |
| 9 | **作業中断時のロールバック** | 不安定な状態を残さない |

---

## 🛠️ トラブルシューティング

### Windows: 「スクリプトの実行が無効」エラー

```
.\setup-windows.ps1 : File cannot be loaded because running scripts is disabled
```

**解決策**: `-ExecutionPolicy Bypass` オプションを使用:

```powershell
powershell -ExecutionPolicy Bypass -File .\setup-windows.ps1
```

### Windows: シンボリックリンク作成に失敗

```
エラー: シンボリックリンクの作成に失敗しました。
```

**解決策**: 以下のいずれかを実行:

1. **管理者権限**で PowerShell を実行
2. **開発者モード**を有効化:
   - 設定 > システム > 開発者向け > 開発者モード をオン

### Mac: Permission denied

```
./setup-mac.sh: Permission denied
```

**解決策**: 実行権限を付与:

```bash
chmod +x setup-mac.sh
```

### ルールが反映されない

1. VS Code / Antigravity を完全に再起動
2. シンボリックリンクが正しく設定されているか確認:
   - Windows: `dir C:\Users\<ユーザー名>\.gemini\`
   - Mac: `ls -la ~/.gemini/`

---

## 📂 関連プロジェクト

このDotfilesに加えて、各プロジェクトには**プロジェクト固有のルール**も設定されています:

| プロジェクト | 固有ルールの場所 |
|-------------|-----------------|
| 勉強会 | `.agent/rules.md` |
| BBQ (ゲーム) | `.agent/rules.md` |

---

## 🔗 参考リンク

- [参考記事: Antigravityの設定をGeminiに聞いてみた](https://zenn.dev/ken1141/articles/4a8810343e5c07)
- [Claude Code サブエージェント完全ガイド](https://note.com/samurai_worker/n/neaec0b51a617)

---

## 📝 更新履歴

- **2026-01-05**: 初期セットアップ。グローバルルールとセットアップスクリプトを作成。

---

## ライセンス

個人利用のための設定ファイルです。
