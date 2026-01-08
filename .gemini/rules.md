# Antigravity グローバルルール

Mac/Windows共通で使えるルール管理システムです。
必要な時に必要なルールを読み込む、Claude Skills風のアプローチ。

---

## 🎯 使い方

セッション中、必要に応じてスラッシュコマンドでルールを読み込みます：

| コマンド | 用途 | いつ使う？ |
|----------|------|-----------|
| `/dev` | 開発・コーディング | コードを書く・修正する時 |
| `/docs` | ドキュメント作成 | 資料・文書を作成する時 |
| `/research` | リサーチ・調査 | 情報収集・分析する時 |
| `/reset` | 基本モードに戻る | 用途別ルールをクリアしたい時 |
| `/sync-rules` | ルール同期 | Dotfilesのルールを更新した後 |

### 使用例
```
ユーザー: /dev
AI: 開発モードが有効になりました。

ユーザー: UserProfileコンポーネントを作成して
AI: （開発ルールに従ってコーディング）
```

---

## 🔴 基本ルール（常に適用）

以下は全セッションで自動的に適用されます。

### 破壊的操作の防止
- `git push --force` 禁止
- `rm -rf` 禁止
- 本番環境への直接操作禁止
- 3ファイル以上の削除は確認必須

### ブランチ強制
- コード変更前に `git branch` を確認
- `main`・`master`・`develop` での直接作業禁止
- 作業用ブランチを作成してから開始

### 日本語化
- すべての成果物は日本語で記述
- コミットメッセージ・コメントも日本語
- 思考プロセスは英語、出力は日本語

### 機密情報の保護
- パスワード・APIキー・トークンを出力しない
- `.env` ファイルの内容を表示しない

### 10ステップ報告
- 処理が10ステップ経過するごとに進捗を報告
- 長時間の処理では定期的にユーザーに状況を伝える

### 自動化の限界と報告
- ツール実行が複数回失敗したら執拗に再試行しない
- 権限不足・環境固有の問題は直ちにユーザーへ報告
- 手動対応を依頼する

### 不要リソースの削除
- テストで作成したファイル・ブランチは不要になったら削除
- 一時ファイルを残さない

### 作業中断時のロールバック
- エラーや中断でタスクを終了する場合
- 修正途中の不安定な状態を残さない
- 作業開始前のクリーンな状態に復元を提案

### ドキュメントの同期
- 機能や仕様を変更した際は、関連ドキュメントも必ず更新
- README、API仕様書、主要なコメント等を同期
- コードだけ変更してドキュメントを放置しない

### ミス学習ループ
- 間違いを犯した場合は `rules.md` への追記を提案
- 同じミスを繰り返さない

---

## 📂 ファイル構成

```
.gemini/
├── rules.md                        # このファイル
├── rules/
│   ├── development.md              # 開発用ルール詳細
│   ├── docs.md                     # ドキュメント作成用ルール詳細
│   └── research.md                 # リサーチ用ルール詳細
└── antigravity/workflows/
    ├── dev.md                      # /dev コマンド
    ├── docs.md                     # /docs コマンド
    ├── research.md                 # /research コマンド
    └── sync-rules.md               # /sync-rules コマンド
```

---

## 🔧 セットアップ

### 初回セットアップ

**Windows (PowerShell)**
```powershell
.\Dotfiles\scripts\setup-antigravity-rules.ps1
```

**Mac/Linux**
```bash
./Dotfiles/scripts/setup-antigravity-rules.sh
```

### ルール更新時

Dotfilesでルールを編集したら、Antigravityで `/sync-rules` を実行するだけ！

```
ユーザー: /sync-rules
AI: （自動でDotfilesからルールをコピー）
    同期が完了しました。最新のルールが適用されています。
```

### 上級者向け：シンボリックリンク方式

管理者権限があれば、シンボリックリンクで自動同期も可能：

**Windows (管理者権限)**
```powershell
Remove-Item -Path "$env:USERPROFILE\.gemini" -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.gemini" -Target "$env:USERPROFILE\Dotfiles\.gemini"
```

**Mac/Linux**
```bash
rm -rf ~/.gemini
ln -s ~/Dotfiles/.gemini ~/.gemini
```

---

## 💡 カスタマイズ

新しいスキルを追加したい場合：

1. `rules/` に新しいルールファイルを作成
2. `antigravity/workflows/` に対応するワークフローを作成
3. このファイルの使い方テーブルに追記

---

*Dotfilesリポジトリで管理: https://github.com/kumakun8325/Dotfiles*
*最終更新: 2026-01-08*
