#!/usr/bin/env python3
"""PreToolUse guard for Bash: hard-deny destructive commands.

Ported from the kiro-cli agents' shared `deniedCommands` list. The command is
tokenized quote-aware and split on shell operators; `$(...)`, backticks and
`sh -c '...'` bodies are checked recursively; common wrappers (env assignments,
timeout, nice, xargs, control-flow keywords, ...) are stripped before matching,
so `cd x && FOO=1 /bin/rm y` is caught while `git commit -m "drop rm; done"`
is not.

This is a guardrail against mistakes, not a security boundary.
Exit 2 blocks the call and feeds stderr back to Claude.
"""
import json
import os
import re
import shlex
import sys

# (pattern, reason) checked against each normalized simple command.
DENY = [
    (r"^(rm|rmdir|shred|unlink)(\s|$)",
     "Permanent delete. Use `trash-put <path>` instead (recover with trash-restore)."),
    (r"^trash-empty(\s|$)",
     "Emptying the trash is a permanent delete; leave it to the human."),
    (r"^find\s.*\s-delete\b",
     "find -delete is a permanent delete. Use `find ... -exec trash-put {} +` instead."),
    (r"^find\s.*\s-exec(dir)?\s+(\S*/)?(rm|shred|unlink)\b",
     "find -exec rm is a permanent delete. Use `-exec trash-put {} +` instead."),
    (r"^sudo(\s|$)",
     "sudo is not allowed. Ask the human to run privileged commands."),
    (r"^git\s(.*\s)?push\b.*(\s--force(-with-lease)?\b|\s-[a-zA-Z]*f\b|\s\+\S)",
     "Force push requires explicit human direction."),
    (r"^git\s(.*\s)?reset\s.*--hard\b",
     "git reset --hard discards work. Ask the human first."),
    (r"^git\s(.*\s)?clean\s(.*\s)?-[a-zA-Z]*f",
     "git clean -f permanently deletes untracked files. Ask the human first."),
    (r"^git\s(.*\s)?branch\b.*(\s-[a-zA-Z]*D\b|--delete\b.*--force\b|--force\b.*--delete\b)",
     "Force-deleting a branch requires explicit human direction."),
]

PIPE_TO_SHELL = re.compile(
    r"\b(curl|wget)\b[^\n]*\|\s*(sudo\s+)?(\S*/)?(sh|bash|zsh|dash|ksh)\b")
SEPARATORS = {"&&", "||", ";", ";;", "|", "|&", "&", "\n"}
SKIP = {"timeout", "time", "nice", "nohup", "stdbuf", "command", "builtin",
        "noglob", "exec", "env", "xargs",
        "(", ")", "{", "}", "!", "if", "then", "else", "elif", "do", "while", "until"}
ENV_ASSIGN = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*=")
SHELLS = {"sh", "bash", "zsh", "dash", "ksh"}
HEREDOC = re.compile(r"<<-?\s*(['\"]?)(\w+)\1[^\n]*\n.*?\n\s*\2(?=\s|$|\))", re.S)
SUBST = re.compile(r"\$\((.*)\)|`([^`]*)`", re.S)


def tokenize(command):
    lex = shlex.shlex(command, posix=True, punctuation_chars="();<>|&\n")
    lex.whitespace = " \t\r"
    lex.whitespace_split = True
    return list(lex)


def simple_commands(command, depth=0):
    command = HEREDOC.sub("", command)
    if depth < 4:
        for m in SUBST.finditer(command):
            yield from simple_commands(m.group(1) or m.group(2) or "", depth + 1)
    try:
        tokens = tokenize(command)
    except ValueError:  # unbalanced quotes: fall back to a crude split
        tokens = re.split(r"\s+|(?=[;&|()\n])|(?<=[;&|()\n])", command)
    current = []
    for tok in tokens + [";"]:
        if tok in SEPARATORS:
            if current:
                yield from expand(current, depth)
            current = []
        elif tok:
            current.append(tok)


def expand(tokens, depth):
    while tokens:
        head = os.path.basename(tokens[0])
        if ENV_ASSIGN.match(tokens[0]):
            tokens = tokens[1:]
        elif head in SKIP:
            tokens = tokens[1:]
            # drop wrapper flags/args like `timeout 30`, `nice -n 5`, `xargs -0`
            while tokens and (tokens[0].startswith("-") or re.match(r"^\d+[smhd]?$", tokens[0])):
                tokens = tokens[1:]
        else:
            break
    if not tokens:
        return
    head = os.path.basename(tokens[0])
    if head in SHELLS and depth < 4:
        for i, t in enumerate(tokens[1:-1], start=1):
            if re.match(r"^-[a-z]*c$", t):
                yield from simple_commands(tokens[i + 1], depth + 1)
                return
    yield " ".join([head] + tokens[1:])


def check(command):
    if PIPE_TO_SHELL.search(command):
        return "Piping a download into a shell. Download, inspect, then run."
    for cmd in simple_commands(command):
        for pattern, reason in DENY:
            if re.search(pattern, cmd):
                return reason
    return None


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        return 0
    command = (data.get("tool_input") or {}).get("command") or ""
    reason = check(command)
    if reason:
        print(f"Blocked by guard-bash: {reason}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
