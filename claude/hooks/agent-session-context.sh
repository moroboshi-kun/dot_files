#!/usr/bin/env bash
# SessionStart hook: per-agent startup context, ported from kiro-cli agentSpawn hooks.
# Stdout is added to Claude's context. Only fires for `claude --agent <name>` sessions.
agent=$(jq -r '.agent_type // empty' 2>/dev/null)

case "$agent" in
  c-linux-embedded)
    echo "## git status"
    timeout 5 git status --short 2>/dev/null || true
    echo "## build files"
    timeout 5 find . -maxdepth 3 \( -name CMakeLists.txt -o -name Makefile -o -name meson.build -o -name compile_commands.json \) 2>/dev/null || true
    ;;
  terraform-dev)
    echo "## terraform version"
    timeout 5 terraform version 2>/dev/null || true
    echo "## git status"
    timeout 5 git status --short 2>/dev/null || true
    ;;
esac
exit 0
