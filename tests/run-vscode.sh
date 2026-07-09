#!/usr/bin/env bash
# Test runner for the VS Code base + overlay settings mechanism.
#
#   1. Hermetic Nix eval of tests/vscode-overlay.nix (mocked pkgs/self/config/lib):
#      asserts the base file, the out-of-store overlay symlink, and that
#      extensions remain declarative.
#   2. A jq deep-merge fixture proving `jq -s '.[0] * .[1]'` gives the exact
#      "overrides win, base preserved" semantics used on activation.
#
# Usage: tests/run-vscode.sh
set -euo pipefail

# Resolve repo paths relative to this script.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# NIX_SSL_CERT_FILE is honored if the caller sets it (e.g. a custom CA);
# otherwise nix uses the system trust store — no hardcoded fallback.

green() { printf '\033[0;32m%s\033[0m\n' "$1"; }
red() { printf '\033[0;31m%b\033[0m\n' "$1"; }

fail() {
  red "FAIL: $1"
  exit 1
}

# --- 1. Hermetic Nix eval --------------------------------------------------

echo "==> [1/2] Nix eval: tests/vscode-overlay.nix"
eval_out="$(nix-instantiate --eval --strict "$SCRIPT_DIR/vscode-overlay.nix" 2>&1)" ||
  fail "nix eval aborted:\n$eval_out"
echo "$eval_out"
case "$eval_out" in
*"ok = true"*) green "  eval assertions passed" ;;
*) fail "eval did not report ok = true" ;;
esac

# --- 2. jq override-wins fixture -------------------------------------------

echo "==> [2/2] jq deep-merge fixture (override-wins precedence)"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

# Base: a value that must survive, and a nested object partially overridden.
cat >"$work/base.json" <<'JSON'
{
  "editor.fontSize": 12,
  "keep.me": "base",
  "nested": { "a": 1, "b": 2 }
}
JSON

# Overrides: override a scalar, add a key, and override one nested key only.
cat >"$work/overrides.json" <<'JSON'
{
  "editor.fontSize": 16,
  "added.by.user": true,
  "nested": { "b": 99 }
}
JSON

merged="$(jq -s '.[0] * .[1]' "$work/base.json" "$work/overrides.json")"
echo "$merged"

check() {
  local desc="$1" filter="$2" expect="$3" got
  got="$(printf '%s' "$merged" | jq -c "$filter")"
  if [ "$got" != "$expect" ]; then
    fail "$desc (expected $expect, got $got)"
  fi
  green "  ok: $desc"
}

# Override wins on a scalar.
check "overrides win on scalar" '.["editor.fontSize"]' '16'
# Base-only key preserved.
check "base-only key preserved" '.["keep.me"]' '"base"'
# Override-only key added.
check "override-only key added" '.["added.by.user"]' 'true'
# Deep merge: overridden nested key wins...
check "nested overridden key wins" '.nested.b' '99'
# ...while the sibling nested key from base is preserved.
check "nested base sibling preserved" '.nested.a' '1'

green "ALL VS CODE OVERLAY TESTS PASSED"
