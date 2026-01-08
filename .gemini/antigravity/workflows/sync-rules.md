---
description: DotfilesからAntigravityルールを同期する
---

# 🔄 ルール同期

DotfilesのルールをAntigravityに同期します。

## 手順

// turbo
1. ルールファイルをコピー
```powershell
Copy-Item "$env:USERPROFILE\Dotfiles\.gemini\rules.md" "$env:USERPROFILE\.gemini\rules.md" -Force
```

// turbo
2. ルールディレクトリを同期
```powershell
Copy-Item "$env:USERPROFILE\Dotfiles\.gemini\rules\*" "$env:USERPROFILE\.gemini\rules\" -Force
```

// turbo
3. ワークフローを同期
```powershell
Copy-Item "$env:USERPROFILE\Dotfiles\.gemini\antigravity\workflows\*" "$env:USERPROFILE\.gemini\antigravity\workflows\" -Force
```

4. 同期完了を確認

---

**同期が完了しました。最新のルールが適用されています。**
