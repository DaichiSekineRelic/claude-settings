# claudeの最適設定を研究するリポジトリ

## セットアップ

このリポジトリのコマンド・スキル・エージェント設定をグローバルの Claude に反映するには、シンボリックリンクを作成します。

```bash
make link
```

`~/.claude/commands`, `~/.claude/skills`, `~/.claude/agents` がこのリポジトリの `.claude/` 配下にリンクされます。

### その他の make コマンド

| コマンド | 説明 |
|---------|------|
| `make link` | グローバル `~/.claude/` へシンボリックリンクを作成 |
| `make unlink` | シンボリックリンクを削除 |
| `make re` | リンクし直す（unlink → link） |
| `make status` | 現在のリンク状態を確認 |

---