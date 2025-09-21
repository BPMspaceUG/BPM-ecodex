#!/usr/bin/env bash
set -euo pipefail

fatal(){ printf 'setup.sh: %s\n' "$1" >&2; exit 1; }
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
BIN_DIR="${PREFIX:-/usr/local/bin}"
command -v install >/dev/null 2>&1 || fatal "missing required: install"
[[ -d "$BIN_DIR" ]] || fatal "target directory not found: $BIN_DIR"
install -m 0755 "$SCRIPT_DIR/ecodex" "$BIN_DIR/ecodex"
install -m 0755 "$SCRIPT_DIR/ecodex-log" "$BIN_DIR/ecodex-log"
mkdir -p "$HOME/.ecodex/logs"
printf 'Installed ecodex and ecodex-log to %s\n' "$BIN_DIR"
