REPO_DIR := $(shell pwd)
CLAUDE_DIR := $(HOME)/.claude

CLAUDE_TARGETS := commands skills agents rules

.PHONY: link unlink re status help

## グローバルの ~/.claude に対してシンボリックリンクを作成する
link:
	@echo "Linking to $(CLAUDE_DIR)/"
	@for target in $(CLAUDE_TARGETS); do \
		src="$(REPO_DIR)/.claude/$$target"; \
		dst="$(CLAUDE_DIR)/$$target"; \
		if [ ! -d "$$src" ]; then \
			echo "  skip  $$target (source not found)"; \
			continue; \
		fi; \
		if [ -L "$$dst" ]; then \
			echo "  skip  $$target (already linked)"; \
		elif [ -e "$$dst" ]; then \
			echo "  skip  $$target ($$dst already exists — remove it manually to link)"; \
		else \
			ln -s "$$src" "$$dst"; \
			echo "  linked $$target -> $$dst"; \
		fi; \
	done
	@echo "Done."

## シンボリックリンクを削除する
unlink:
	@echo "Unlinking from $(CLAUDE_DIR)/"
	@for target in $(CLAUDE_TARGETS); do \
		dst="$(CLAUDE_DIR)/$$target"; \
		if [ -L "$$dst" ]; then \
			rm "$$dst"; \
			echo "  removed $$target"; \
		else \
			echo "  skip  $$target (not a symlink)"; \
		fi; \
	done
	@echo "Done."

## unlink してから link し直す
re: unlink link

## リンク状態を確認する
status:
	@echo "Symlink status in $(CLAUDE_DIR)/"
	@for target in $(CLAUDE_TARGETS); do \
		dst="$(CLAUDE_DIR)/$$target"; \
		if [ -L "$$dst" ]; then \
			echo "  [linked] $$target -> $$(readlink $$dst)"; \
		elif [ -d "$$dst" ]; then \
			echo "  [dir]    $$target (real directory, not linked)"; \
		else \
			echo "  [none]   $$target"; \
		fi; \
	done

help:
	@echo "Usage:"
	@echo "  make link    グローバル ~/.claude へシンボリックリンクを作成"
	@echo "  make unlink  シンボリックリンクを削除"
	@echo "  make re      リンクし直す (unlink + link)"
	@echo "  make status  リンク状態を確認"
