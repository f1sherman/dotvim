#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

env -u HNP_HERDR_SSH HERDR_ENV=1 DISPLAY=:99 \
  nvim --headless -u "$repo_dir/vimrc" \
  "+redir! > $tmp_dir/provider" \
  '+silent echo provider#clipboard#Executable()' \
  '+redir END' \
  '+qall'

provider=$(tr -d '\r\n' <"$tmp_dir/provider")
if [[ "$provider" != "OSC 52" ]]; then
  printf 'FAIL: Herdr selected clipboard provider %q, expected OSC 52\n' \
    "$provider" >&2
  exit 1
fi

marker='herdr-nvim-clipboard-probe'
encoded=$(printf '%s' "$marker" | base64 -w0)
env -u HNP_HERDR_SSH HERDR_ENV=1 TERM=xterm-256color script -qefc \
  "nvim -u '$repo_dir/vimrc' -n \
  '+call setreg(\"+\", \"$marker\")' '+qall!'" \
  "$tmp_dir/terminal" >/dev/null
if ! LC_ALL=C grep -aF "]52;c;$encoded" "$tmp_dir/terminal" >/dev/null; then
  printf 'FAIL: special-register copy did not emit the OSC 52 payload\n' >&2
  exit 1
fi

env -u HNP_HERDR_SSH HERDR_ENV=1 TMUX=/tmp/tmux DISPLAY=:99 \
  nvim --headless -u "$repo_dir/vimrc" \
  "+redir! > $tmp_dir/tmux-provider" \
  '+silent echo provider#clipboard#Executable()' \
  '+redir END' \
  '+qall'

tmux_provider=$(tr -d '\r\n' <"$tmp_dir/tmux-provider")
if [[ "$tmux_provider" == "OSC 52" ]]; then
  printf 'FAIL: Herdr overrode nested tmux with OSC 52\n' >&2
  exit 1
fi

printf 'PASS: Herdr uses OSC 52 and nested tmux keeps automatic selection\n'
