---
description: Git操作（コミット・ロールバック）
---

# 🔧 Git操作

Git関連の操作を管理します。

## 使い方

```
/git commit   → 変更をコミット・プッシュ
/git rollback → 変更をロールバック
```

---

## /git commit

現在の変更をGitにコミットし、GitHubにプッシュします。

// turbo-all

### Step 1: 変更状況の確認
```bash
git status
```

### Step 2: ステージング
```bash
git add .
```

### Step 3: コミット
コミットメッセージを確認してコミット：
```bash
git commit -m "[コミットメッセージ]"
```

### Step 4: プッシュ
```bash
git push
```

### Step 5: 完了報告
- コミットハッシュ
- 変更されたファイル数
- GitHubリポジトリURL

---

## コミットメッセージ規約

| プレフィックス | 用途 |
|--------------|------|
| `feat:` | 新機能追加 |
| `fix:` | バグ修正 |
| `docs:` | ドキュメント変更 |
| `chore:` | 雑務（設定変更等） |
| `refactor:` | リファクタリング |
| `test:` | テスト追加・修正 |

---

## /git rollback

誤った操作や失敗した変更を元に戻します。

### Step 1: 状況の確認
// turbo
```bash
git status
git log --oneline -5
```

### Step 2: ロールバック方法の選択

#### A. 直前のコミットを取り消す
```bash
# 変更を保持したまま取り消し
git reset --soft HEAD~1

# 完全に取り消し（⚠️ 確認必須）
git reset --hard HEAD~1
```

#### B. 作業中の変更を退避
```bash
git stash push -m "作業中の変更を退避"
git stash pop  # 復元
```

### Step 3: 復旧確認
// turbo
```bash
git status
npm run build
npm test
```

---

## ⚠️ 注意事項

- `git push --force` は原則禁止
- ロールバック前に必ず現在の状態を記録
- 不安な場合はバックアップブランチを作成

---

## 🌿 ブランチ運用ルール

### ブランチ命名規則

| パターン | 例 |
|---------|--------|
| 勉強会テーマ | `session/第4回-テーマ名` |
| 機能追加 | `feature/機能名` |
| バグ修正 | `fix/修正内容` |
